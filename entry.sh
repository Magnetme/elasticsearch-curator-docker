#!/bin/sh

set -e

# Set the variables in the config
cp /opt/curator/files/config.yml /tmp/config.yml
sed -i s/_ES_HOST_/${ES_HOST}/g /tmp/config.yml
sed -i s/_ES_PORT_/${ES_PORT}/g /tmp/config.yml
sed -i s/_ES_PREFIX_/${ES_PREFIX}/g /tmp/config.yml

# Pick the correct action and copy it
cp /opt/curator/files/actions/${ACTION}.yml /tmp/action.yml

# Replace any values in that file
sed -i s/_THRESHOLD_/${THRESHOLD}/g /tmp/action.yml

echo '---------RUNNING WITH CONFIGURATION---------'
cat /tmp/config.yml

echo
echo '---------RUNNING WITH ACTION---------'
cat /tmp/action.yml

# Execute the curator magic
if [ "${DRY_RUN}" == "false" ]; then
	/usr/bin/curator --config /tmp/config.yml /tmp/action.yml
else
	echo '------------DRY RUN---------------'
	/usr/bin/curator --config /tmp/config.yml --dry-run /tmp/action.yml
fi
