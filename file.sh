read -p "link to sourcecode.tar.gz: " source
mkdir temp; pushd temp
wget $source
tar -xzvf *.tar.gz
rm *.tar.gz
pushd Mindustry*
chmod +x gradlew

read -p "Configure? (y/n)" confirm && if [[ "$confirm" =~ ^[Yy]+([eE][sS])?$ ]]; then read -p "Modify turn duration to change round time, hit enter to continue" useless; nano core/src/mindustry/Vars.java; fi
./gradlew server:dist
unset confirm

read -p "custom file name? default: modded (y/n)" confirm && if [[ "$confirm" =~ ^[Yy]+([eE][sS])?$ ]]; then read -p "File name: " filename;rm ../../$filename >> /dev/null; mv server/build/libs/server-release.jar ../../$filename.jar; pushd ../../; touch $filename.sh; chmod +x *.sh; echo "java -jar $filename.jar" > $filename.sh; popd


else mv server/build/libs/server-release.jar ../../modded.jar; fi

popd; popd
rm -rf temp

unset source, filename, confirm
