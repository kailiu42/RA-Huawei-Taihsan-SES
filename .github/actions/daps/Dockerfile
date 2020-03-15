FROM opensuse/tumbleweed

# Define your additional repositories here
#RUN zypper ar -n openSUSE-Tumbleweed-Oss http://download.opensuse.org/tumbleweed/repo/oss/ repo-oss

# openSUSE-release required to work around https://github.com/openSUSE/obs-build/issues/487
RUN zypper install -y openSUSE-release-appliance-docker daps suse-xsl-stylesheets \
        ruby2.6-rubygem-asciidoctor git make tar

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]