# Before running this script, install ttab by running the command: npm -g install ttab
# Since Saathratri Orchestrator has a startup/scheduled task that depends on other microservices like Organizations Service,
# we start/deploy the orchestrator separately once all other services have been deployed.

CURRENT_FOLDER="$PWD"

echo "Deploying Service A..."
ttab -t service-a -d "$CURRENT_FOLDER/service-a" ./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8000"

echo "Deploying Service B..."
ttab -t service-b -d "$CURRENT_FOLDER/service-b" ./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8001"

echo "Deploying Gateway..."
ttab -t spring-cloud-gateway -d "$CURRENT_FOLDER/spring-cloud-gateway" ./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8002"

echo "Check opened tabs to see deployment status of Service A, Service B and their Gateway."

