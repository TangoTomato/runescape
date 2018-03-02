#runescape
#!/bin/sh
CLIENT_LINK="http://www.runescape.com/downloads/runescape.dmg"
GAME_LOC="$HOME/jagexcache/runescape/bin"
# temporary directory used by the script: its contents will be deleted.
RS_TMP="$HOME/rstmp39383"
# Check if 7zip is installed (required to extract the DMG)
if [ ! -f /usr/bin/7z ]; then
	echo "It appears you do not have '7zip' installed, which is required to extract the download. To install it, run: \n\nsudo apt-get install p7zip-full"
	exit
fi
if [ ! -d $GAME_LOC ]; then
	# Create the directory for the client
	mkdir -p $GAME_LOC
	# Make a temporary folder to store extracted files
	mkdir $RS_TMP
	cd $RS_TMP 
	wget -q $CLIENT_LINK
	# Extract the downloadable Mac client and the hfs file to get the jar and icon
	7z e runescape.dmg 2> /dev/null
	7z e 0.hfs -y 2> /dev/null
	# Move the required files to the client directory created earlier
	mv jagexappletviewer.{jar,png} $GAME_LOC
        cd ~
	# Delete the temporary folder
	rm -rf $RS_TMP
fi
# Run the client
java -Djava.class.path="$GAME_LOC/jagexappletviewer.jar" -Dcom.jagex.config=http://www.runescape.com/k=3/l=en/jav_config.ws jagexappletviewer "$GAME_LOC" > /dev/null
