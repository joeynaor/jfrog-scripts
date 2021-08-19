if [[ $# -eq 0 ]] ; then
    echo 'Usage: ./rt-tomcat.sh <rt-version>'
    echo 'Example: ./rt-tomcat.sh 7.24.3'
    exit 0
fi
version=$1
if [[ $version == 6* ]];
then
  filename="$version.zip"
  decompress="unzip"
  catpath="/tomcat/lib/catalina.jar"
elif [[ $version == 7* ]]
then
  filename="$version-linux.tar.gz"
  decompress="tar -xvf"
  catpath="/app/artifactory/tomcat/lib/catalina.jar"
else
  echo 'Bad version.'
  exit 0
fi
cd /tmp/;
wget https://releases.jfrog.io/artifactory/artifactory-pro/org/artifactory/pro/jfrog-artifactory-pro/$version/jfrog-artifactory-pro-$filename
$decompress jfrog-artifactory-pro-$filename;
java -cp artifactory-pro-$version/$catpath org.apache.catalina.util.ServerInfo
