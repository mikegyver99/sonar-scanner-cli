FROM registry.access.redhat.com/ubi8

ARG flutter_pkg_name_version=3.22.2
ARG flutter_pkg_name=flutter_linux_${flutter_pkg_name_version}-stable
ARG sonar_scanner_cli_version=6.1.0.4477
ARG sonar_scanner_cli_name=sonar-scanner-cli-${sonar_scanner_cli_version}-linux-x64
ARG sonar_scanner_cli_path=sonar-scanner-${sonar_scanner_cli_version}-linux-x64

RUN yum -y -q update && \
    yum install -y -q wget tar git unzip jq && \
    wget -q https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/${flutter_pkg_name}.tar.xz && \
    tar -xf ${flutter_pkg_name}.tar.xz && \
    wget -q https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/${sonar_scanner_cli_name}.zip && \
    unzip ${sonar_scanner_cli_name}.zip && \
    # Set symlinks so commands work without calling full path
    ln -sr ${sonar_scanner_cli_path}/bin/sonar-scanner /usr/local/bin/sonar-scanner && \
    ln -sr ${CI_PROJECT_DIR}/flutter/bin/flutter /usr/local/bin/flutter && \
    ln -sr ${CI_PROJECT_DIR}/flutter/bin/cache/dart-sdk/bin/dart /usr/local/bin/dart && \
    rm -f ${flutter_pkg_name}.tar.xz ${sonar_scanner_cli_name}.zip
