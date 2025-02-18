source comp.sh annuaire-jpa
cp annuaire-jpa.war ~/install/apache-tomcat-11.0.1/webapps/.
cd facade
./mvnw package
cd -
cp facade/target/facade-0.0.1-SNAPSHOT.war ~/install/apache-tomcat-11.0.1/webapps/facade.war

