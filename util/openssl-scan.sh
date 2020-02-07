#!/bin/bash

# Exit on first error
set -e

begin=$(date)

# Analyze in docker
docker run -v /home/tsm/openssl/openssl:/openssl -it --rm davxy/sonar-builder /bin/bash -c "cd openssl && ./util/sonar-run.sh"

end=$(date)

# Disable exit on first error
set +e

echo "Analysis begin: $begin"
echo "Analysis end:   $end"
