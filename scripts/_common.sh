#!/bin/bash

#=================================================
#=================================================
# TESTING
#=================================================
#=================================================

YNH_EXECUTION_DIR="."

ynh_backup_abstract () {
	# A intégrer à ynh_backup directement.
	ynh_backup "$@"
	echo "$2" "$1" >> backup_list
}

ynh_restore_file () {
	file_and_dest=$(grep "^$1" backup_list)
	backup_file=${file_and_dest%% *}
	backup_dest=${file_and_dest#* }
	if [ -f "$backup_dest" ]; then
		ynh_die "There is already a file at this path: $backup_dest"
	fi
	if test -d "$backup_file"; then
		sudo cp -a "$backup_file/." "$backup_dest"
	else
		sudo cp -a "$backup_file" "$backup_dest"
	fi
}

ynh_fpm_config () {
	finalphpconf="/etc/php5/fpm/pool.d/$app.conf"
	ynh_backup_if_checksum_is_different "$finalphpconf" 1
	sudo cp ../conf/php-fpm.conf "$finalphpconf"
	ynh_replace_string "__NAMETOCHANGE__" "$app" "$finalphpconf"
	ynh_replace_string "__FINALPATH__" "$final_path" "$finalphpconf"
	ynh_replace_string "__USER__" "$app" "$finalphpconf"
	sudo chown root: "$finalphpconf"
	ynh_store_file_checksum "$finalphpconf"

	if [ -e "../conf/php-fpm.ini" ]
	then
		finalphpini="/etc/php5/fpm/conf.d/20-$app.ini"
		ynh_backup_if_checksum_is_different "$finalphpini" 1
		sudo cp ../conf/php-fpm.ini "$finalphpini"
		sudo chown root: "$finalphpini"
		ynh_store_file_checksum "$finalphpini"
	fi

	sudo systemctl reload php5-fpm
}

ynh_remove_fpm_config () {
	ynh_secure_remove "/etc/php5/fpm/pool.d/$app.conf"
	ynh_secure_remove "/etc/php5/fpm/conf.d/20-$app.ini"
	sudo systemctl reload php5-fpm
}

ynh_nginx_config () {
	finalnginxconf="/etc/nginx/conf.d/$domain.d/$app.conf"
	ynh_backup_if_checksum_is_different "$finalnginxconf" 1
	sudo cp ../conf/nginx.conf "$finalnginxconf"

	# To avoid a break by set -u, use a void substitution ${var:-}. If the variable is not set, it's simply set with an empty variable.
	# Substitute in a nginx config file only if the variable is not empty
	if test -n "${path_url:-}"; then
		ynh_replace_string "__PATH__" "$path_url" "$finalnginxconf"
	fi
	if test -n "${domain:-}"; then
		ynh_replace_string "__DOMAIN__" "$domain" "$finalnginxconf"
	fi
	if test -n "${port:-}"; then
		ynh_replace_string "__PORT__" "$port" "$finalnginxconf"
	fi
	if test -n "${app:-}"; then
		ynh_replace_string "__NAME__" "$app" "$finalnginxconf"
	fi
	if test -n "${final_path:-}"; then
		ynh_replace_string "__FINALPATH__" "$final_path" "$finalnginxconf"
	fi
	ynh_store_file_checksum "$finalnginxconf"

	sudo systemctl reload nginx
}

ynh_remove_nginx_config () {
	ynh_secure_remove "/etc/nginx/conf.d/$domain.d/$app.conf"
	sudo systemctl reload nginx
}

#=================================================
#=================================================

#=================================================
# CHECKING
#=================================================

CHECK_DOMAINPATH () {	# Vérifie la disponibilité du path et du domaine.
	sudo yunohost app checkurl $domain$path_url -a $app
}

CHECK_FINALPATH () {	# Vérifie que le dossier de destination n'est pas déjà utilisé.
	final_path=/var/www/$app
	test ! -e "$final_path" || ynh_die "This path already contains a folder"
}

#=================================================
# DISPLAYING
#=================================================

WARNING () {	# Écrit sur le canal d'erreur pour passer en warning.
	$@ >&2
}

QUIET () {	# Redirige la sortie standard dans /dev/null
	$@ > /dev/null
}

#=================================================
# BACKUP
#=================================================

BACKUP_FAIL_UPGRADE () {
	WARNING echo "Upgrade failed."
	app_bck=${app//_/-}	# Replace all '_' by '-'
	if sudo yunohost backup list | grep -q $app_bck-pre-upgrade$backup_number; then	# Vérifie l'existence de l'archive avant de supprimer l'application et de restaurer
		sudo yunohost app remove $app	# Supprime l'application avant de la restaurer.
		sudo yunohost backup restore --ignore-hooks $app_bck-pre-upgrade$backup_number --apps $app --force	# Restore the backup if upgrade failed
		ynh_die "The app was restored to the way it was before the failed upgrade."
	fi
}

BACKUP_BEFORE_UPGRADE () {	# Backup the current version of the app, restore it if the upgrade fails
	backup_number=1
	old_backup_number=2
	app_bck=${app//_/-}	# Replace all '_' by '-'
	if sudo yunohost backup list | grep -q $app_bck-pre-upgrade1; then	# Vérifie l'existence d'une archive déjà numéroté à 1.
		backup_number=2	# Et passe le numéro de l'archive à 2
		old_backup_number=1
	fi

	sudo yunohost backup create --ignore-hooks --apps $app --name $app_bck-pre-upgrade$backup_number	# Créer un backup différent de celui existant.
	if [ "$?" -eq 0 ]; then	# Si le backup est un succès, supprime l'archive précédente.
		if sudo yunohost backup list | grep -q $app_bck-pre-upgrade$old_backup_number; then	# Vérifie l'existence de l'ancienne archive avant de la supprimer, pour éviter une erreur.
			QUIET sudo yunohost backup delete $app_bck-pre-upgrade$old_backup_number
		fi
	else	# Si le backup a échoué
		ynh_die "Backup failed, the upgrade process was aborted."
	fi
}

HUMAN_SIZE () {	# Transforme une taille en Ko en une taille lisible pour un humain
	human=$(numfmt --to=iec --from-unit=1K $1)
	echo $human
}

CHECK_SIZE () {	# Vérifie avant chaque backup que l'espace est suffisant
	file_to_analyse=$1
	backup_size=$(sudo du --summarize "$file_to_analyse" | cut -f1)
	free_space=$(sudo df --output=avail "/home/yunohost.backup" | sed 1d)

	if [ $free_space -le $backup_size ]
	then
		WARNING echo "Espace insuffisant pour sauvegarder $file_to_analyse."
		WARNING echo "Espace disponible: $(HUMAN_SIZE $free_space)"
		ynh_die "Espace nécessaire: $(HUMAN_SIZE $backup_size)"
	fi
}

#=================================================
#=================================================
# FUTUR YNH HELPERS
#=================================================
# Importer ce fichier de fonction avant celui des helpers officiel
# Ainsi, les officiels prendront le pas sur ceux-ci le cas échéant
#=================================================

# Normalize the url path syntax
# Handle the slash at the beginning of path and its absence at ending
# Return a normalized url path
#
# example: url_path=$(ynh_normalize_url_path $url_path)
#          ynh_normalize_url_path example -> /example
#          ynh_normalize_url_path /example -> /example
#          ynh_normalize_url_path /example/ -> /example
#          ynh_normalize_url_path / -> /
#
# usage: ynh_normalize_url_path path_to_normalize
# | arg: url_path_to_normalize - URL path to normalize before using it
ynh_normalize_url_path () {
	path_url=$1
	test -n "$path_url" || ynh_die "ynh_normalize_url_path expect a URL path as first argument and received nothing."
	if [ "${path_url:0:1}" != "/" ]; then    # If the first character is not a /
		path_url="/$path_url"    # Add / at begin of path variable
	fi
	if [ "${path_url:${#path_url}-1}" == "/" ] && [ ${#path_url} -gt 1 ]; then    # If the last character is a / and that not the only character.
		path_url="${path_url:0:${#path_url}-1}"	# Delete the last character
	fi
	echo $path_url
}

# Manage a fail of the script
#
# Print a warning to inform that the script was failed
# Execute the ynh_clean_setup function if used in the app script
#
# usage of ynh_clean_setup function
# This function provide a way to clean some residual of installation that not managed by remove script.
# To use it, simply add in your script:
# ynh_clean_setup () {
#        instructions...
# }
# This function is optionnal.
#
# Usage: ynh_exit_properly is used only by the helper ynh_abort_if_errors.
# You must not use it directly.
ynh_exit_properly () {
	exit_code=$?
	if [ "$exit_code" -eq 0 ]; then
			exit 0	# Exit without error if the script ended correctly
	fi

	trap '' EXIT	# Ignore new exit signals
	set +eu	# Do not exit anymore if a command fail or if a variable is empty

	echo -e "!!\n  $app's script has encountered an error. Its execution was cancelled.\n!!" >&2

	if type -t ynh_clean_setup > /dev/null; then	# Check if the function exist in the app script.
		ynh_clean_setup	# Call the function to do specific cleaning for the app.
	fi

	ynh_die	# Exit with error status
}

# Exit if an error occurs during the execution of the script.
#
# Stop immediatly the execution if an error occured or if a empty variable is used.
# The execution of the script is derivate to ynh_exit_properly function before exit.
#
# Usage: ynh_abort_if_errors
ynh_abort_if_errors () {
	set -eu	# Exit if a command fail, and if a variable is used unset.
	trap ynh_exit_properly EXIT	# Capturing exit signals on shell script
}

# Create a system user
#
# usage: ynh_system_user_create user_name [home_dir]
# | arg: user_name - Name of the system user that will be create
# | arg: home_dir - Path of the home dir for the user. Usually the final path of the app. If this argument is omitted, the user will be created without home
ynh_system_user_create () {
	if ! ynh_system_user_exists "$1"	# Check if the user exists on the system
	then	# If the user doesn't exist
		if [ $# -ge 2 ]; then	# If a home dir is mentioned
			user_home_dir="-d $2"
		else
			user_home_dir="--no-create-home"
		fi
		sudo useradd $user_home_dir --system --user-group $1 --shell /usr/sbin/nologin || ynh_die "Unable to create $1 system account"
	fi
}

# Delete a system user
#
# usage: ynh_system_user_delete user_name
# | arg: user_name - Name of the system user that will be create
ynh_system_user_delete () {
    if ynh_system_user_exists "$1"	# Check if the user exists on the system
    then
		echo "Remove the user $1" >&2
		sudo userdel $1
	else
		echo "The user $1 was not found" >&2
    fi
}

# Substitute/replace a string by another in a file
#
# usage: ynh_replace_string match_string replace_string target_file
# | arg: match_string - String to be searched and replaced in the file
# | arg: replace_string - String that will replace matches
# | arg: target_file - File in which the string will be replaced.
ynh_replace_string () {
	delimit=@
	match_string=${1//${delimit}/"\\${delimit}"}	# Escape the delimiter if it's in the string.
	replace_string=${2//${delimit}/"\\${delimit}"}
	workfile=$3

	sudo sed --in-place "s${delimit}${match_string}${delimit}${replace_string}${delimit}g" "$workfile"
}

# Remove a file or a directory securely
#
# usage: ynh_secure_remove path_to_remove
# | arg: path_to_remove - File or directory to remove
ynh_secure_remove () {
	path_to_remove=$1
	forbidden_path=" \
	/var/www \
	/home/yunohost.app"

	if [[ "$forbidden_path" =~ "$path_to_remove" \
		# Match all paths or subpaths in $forbidden_path
		|| "$path_to_remove" =~ ^/[[:alnum:]]+$ \
		# Match all first level paths from / (Like /var, /root, etc...)
		|| "${path_to_remove:${#path_to_remove}-1}" = "/" ]]
		# Match if the path finishes by /. Because it seems there is an empty variable
	then
		echo "Avoid deleting $path_to_remove." >&2
	else
		if [ -e "$path_to_remove" ]
		then
			sudo rm -R "$path_to_remove"
		else
			echo "$path_to_remove wasn't deleted because it doesn't exist." >&2
		fi
	fi
}

# Download, check integrity, uncompress and patch the source from app.src
#
# The file conf/app.src need to contains:
# 
# SOURCE_URL=Address to download the app archive
# SOURCE_SUM=Control sum
# # (Optional) Programm to check the integrity (sha256sum, md5sum$YNH_EXECUTION_DIR/...)
# # default: sha256
# SOURCE_SUM_PRG=sha256
# # (Optional) Archive format
# # default: tar.gz
# SOURCE_FORMAT=tar.gz
# # (Optional) Put false if source are directly in the archive root
# # default: true
# SOURCE_IN_SUBDIR=false
# # (Optionnal) Name of the local archive (offline setup support)
# # default: ${src_id}.${src_format}
# SOURCE_FILENAME=example.tar.gz 
#
# Details:
# This helper download sources from SOURCE_URL if there is no local source
# archive in /opt/yunohost-apps-src/APP_ID/SOURCE_FILENAME
# 
# Next, it check the integrity with "SOURCE_SUM_PRG -c --status" command.
# 
# If it's ok, the source archive will be uncompress in $dest_dir. If the
# SOURCE_IN_SUBDIR is true, the first level directory of the archive will be
# removed.
#
# Finally, patches named sources/patches/${src_id}-*.patch and extra files in
# sources/extra_files/$src_id will be applyed to dest_dir
#
#
# usage: ynh_setup_source dest_dir [source_id]
# | arg: dest_dir  - Directory where to setup sources
# | arg: source_id - Name of the app, if the package contains more than one app
ynh_setup_source () {
	local dest_dir=$1
	local src_id=${2:-app} # If the argument is not given, source_id equal "app"

	# Load value from configuration file (see above for a small doc about this file
	# format)
	local src_url=$(grep 'SOURCE_URL=' "$YNH_EXECUTION_DIR/../conf/${src_id}.src" | cut -d= -f2-)
	local src_sum=$(grep 'SOURCE_SUM=' "$YNH_EXECUTION_DIR/../conf/${src_id}.src" | cut -d= -f2-)
	local src_sumprg=$(grep 'SOURCE_SUM_PRG=' "$YNH_EXECUTION_DIR/../conf/${src_id}.src" | cut -d= -f2-)
	local src_format=$(grep 'SOURCE_FORMAT=' "$YNH_EXECUTION_DIR/../conf/${src_id}.src" | cut -d= -f2-)
	local src_in_subdir=$(grep 'SOURCE_IN_SUBDIR=' "$YNH_EXECUTION_DIR/../conf/${src_id}.src" | cut -d= -f2-)
	local src_filename=$(grep 'SOURCE_FILENAME=' "$YNH_EXECUTION_DIR/../conf/${src_id}.src" | cut -d= -f2-)

	# Default value
	src_sumprg=${src_sumprg:-sha256sum}
	src_in_subdir=${src_in_subdir:-true}
	src_format=${src_format:-tar.gz}
	src_format=$(echo "$src_format" | tr '[:upper:]' '[:lower:]')
	if [ "$src_filename" = "" ] ; then
		src_filename="${src_id}.${src_format}"
	fi
	local local_src="/opt/yunohost-apps-src/${YNH_APP_ID}/${src_filename}"

	if test -e "$local_src"
	then    # Use the local source file if it is present
		sudo cp $local_src $src_filename
	else    # If not, download the source
		wget -nv -O $src_filename $src_url
	fi

	# Check the control sum
	echo "${src_sum} ${src_filename}" | ${src_sumprg} -c --status \
		|| ynh_die "Corrupt source"

	# Extract source into the app dir
	sudo mkdir -p "$dest_dir"
	if [ "$src_format" = "zip" ]
	then 
		# Zip format
		# Using of a temp directory, because unzip doesn't manage --strip-components
		if $src_in_subdir ; then
			local tmp_dir=$(mktemp -d)
			unzip -quo $src_filename -d "$tmp_dir"
			sudo cp -a $tmp_dir/*/. "$dest_dir"
			ynh_secure_remove "$tmp_dir"
		else
			sudo unzip -quo $src_filename -d "$dest_dir"
		fi
	else
		local strip=""
		if $src_in_subdir ; then
			strip="--strip-components 1"
		fi
		if [[ "$src_format" =~ ^tar.gz|tar.bz2|tar.xz$ ]] ; then
			sudo tar -xf $src_filename -C "$dest_dir" $strip
		else
			ynh_die "Archive format unrecognized."
		fi
	fi

	# Apply patches
	if (( $(find $YNH_EXECUTION_DIR/../sources/patches/ -type f -name "${src_id}-*.patch" 2> /dev/null | wc -l) > "0" )); then
		local old_dir=$(pwd)
		(cd "$dest_dir" \
			&& for p in $YNH_EXECUTION_DIR/../sources/patches/${src_id}-*.patch; do \
				patch -p1 < $p; done) \
			|| ynh_die "Unable to apply patches"
		cd $old_dir
	fi

	# Add supplementary files
	if test -e "$YNH_EXECUTION_DIR/../sources/extra_files/${src_id}"; then
		cp -a $YNH_EXECUTION_DIR/../sources/extra_files/$src_id/. "$dest_dir"
	fi

}

# Calculate and store a file checksum into the app settings
#
# $app should be defined when calling this helper
#
# usage: ynh_store_file_checksum file
# | arg: file - The file on which the checksum will performed, then stored.
ynh_store_file_checksum () {
	local checksum_setting_name=checksum_${1//[\/ ]/_}	# Replace all '/' and ' ' by '_'
	ynh_app_setting_set $app $checksum_setting_name $(sudo md5sum "$1" | cut -d' ' -f1)
}

# Verify the checksum and backup the file if it's different
# This helper is primarily meant to allow to easily backup personalised/manually 
# modified config files.
#
# $app should be defined when calling this helper
#
# usage: ynh_backup_if_checksum_is_different file
# | arg: file - The file on which the checksum test will be perfomed.
#
# | ret: Return the name a the backup file, or nothing
ynh_backup_if_checksum_is_different () {
	local file=$1
	local checksum_setting_name=checksum_${file//[\/ ]/_}	# Replace all '/' and ' ' by '_'
	local checksum_value=$(ynh_app_setting_get $app $checksum_setting_name)
	if [ -n "$checksum_value" ]
	then	# Proceed only if a value was stored into the app settings
		if ! echo "$checksum_value $file" | sudo md5sum -c --status
		then	# If the checksum is now different
			backup_file="/home/yunohost.conf/backup/$file.backup.$(date '+%Y%m%d.%H%M%S')"
			sudo mkdir -p "$(dirname "$backup_file")"
			sudo cp -a "$file" "$backup_file"	# Backup the current file
			echo "File $file has been manually modified since the installation or last upgrade. So it has been duplicated in $backup_file" >&2
			echo "$backup_file"	# Return the name of the backup file
		fi
	fi
}
