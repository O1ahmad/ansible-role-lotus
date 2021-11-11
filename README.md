<p><img src="https://code.benco.io/icon-collection/logos/ansible.svg" alt="ansible logo" title="ansible" align="left" height="60" /></p>
<p><img src="https://filecoin.io/uploads/lotus.png" alt="lotus logo" title="lotus" align="right" height="90" /></p>

Ansible Role :cherry_blossom: :link: Lotus
=========
[![Galaxy Role](https://img.shields.io/ansible/role/45346.svg)](https://galaxy.ansible.com/0x0I/lotus)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/0x0I/ansible-role-lotus?color=yellow)
[![Downloads](https://img.shields.io/ansible/role/d/45346.svg?color=lightgrey)](https://galaxy.ansible.com/0x0I/lotus)
[![Build Status](https://travis-ci.org/0x0I/ansible-role-lotus.svg?branch=master)](https://travis-ci.org/0x0I/ansible-role-lotus)
[![License: MIT](https://img.shields.io/badge/License-MIT-blueviolet.svg)](https://opensource.org/licenses/MIT)

**Table of Contents**
  - [Supported Platforms](#supported-platforms)
  - [Requirements](#requirements)
  - [Role Variables](#role-variables)
      - [Install](#install)
      - [Config](#config)
      - [Launch](#launch)
      - [Uninstall](#uninstall)
  - [Dependencies](#dependencies)
  - [Example Playbook](#example-playbook)
  - [License](#license)
  - [Author Information](#author-information)

Ansible role that installs and configures Lotus: a Go-implementation of the Filecoin distributed storage network blockchain protocol.

##### Supported Platforms:
```
* Debian
* Redhat(CentOS/Fedora)
* Ubuntu
```

Requirements
------------

Requires the `unzip/gtar` utility to be installed on the target host. See ansible `unarchive` module [notes](https://docs.ansible.com/ansible/latest/modules/unarchive_module.html#notes) for details.

Role Variables
--------------
Variables are available and organized according to the following software & machine provisioning stages:
* _install_
* _config_
* _launch_
* _uninstall_

#### Install

`lotus_user: <service-user-name>` (**default**: *lotus*)
- dedicated service user and group used by `lotus` for privilege separation (see [here](https://www.beyondtrust.com/blog/entry/how-separation-privilege-improves-security) for details)

`install_type: <archive | source>` (**default**: archive)
- **archive**: currently supported by Ubuntu and Fedora distributions (due to availibity of version >= 2.27 of the `glibc` *GNU libc libraries* package -- see [here](http://fr2.rpmfind.net/linux/rpm2html/search.php?query=glibc&submit=Search+...&system=&arch=) for per-distribution package availability) and compatible with both **tar and zip** formats, installation of Lotus via compressed archives results in the direct download of its component binaries, the `lotus` network client and `lotus-miner` mining software, from the specified archive url.

  **note:** archived installation binaries can be obtained from the official [releases](https://github.com/filecoin-project/lotus/releases) site or those generated from development/custom sources.

- **source**: build *lotus network client* and *storage miner* binaries from source. This installation process consists of cloning the github hosted [repository](https://github.com/filecoin-project/lotus) and building from source code using `make` directives. See [here](https://docs.lotu.sh/en+install-lotus-ubuntu) for more details on building from source.

`install_dir: </path/to/installation/dir>` (**default**: `/opt/lotus`)
- path on target host where the `lotus` binaries should be extracted to.

`include_benchmarks: <true|false>` (**default**: `false`)
- to build and install `lotus-bench`.  More information [here](https://docs.filecoin.io/mine/lotus/benchmarks/).

`archive_url: <path-or-url-to-archive>` (**default**: see `defaults/main.yml`)
- address of a compressed **tar or zip** archive containing `lotus` binaries. This method technically supports installation of any available version of `lotus`. Links to official versions can be found [here](https://github.com/filecoin-project/lotus/releases).

`archive_checksum: <path-or-url-to-checksum>` (**default**: see `defaults/main.yml`)
- address of a checksum file for verifying the data integrity of the specified archive. While recommended and generally considered a best practice, specifying a checksum is *not required* and can be disabled by providing an empty string (`''`) for its value.

`checksum_format: <string>` (**default**: see `sha512`)
- hash algorithm used for file verification associated with the specified archive or package checksum. Reference [here](https://en.wikipedia.org/wiki/Cryptographic_hash_function) for more information about *checksums/cryptographic* hashes.

`git_url: <path-or-url-to-git-repo>` (**default**: see `defaults/main.yml`)
- address of `lotus` git repository. Address can reference the [Github](https://github.com/filecoin-project/lotus) site address or custom source hosted on an alternate git hosting site.

`git_version: <string>` (**default**: `v0.1.0`)
- version of the repository to check out. This can be the literal string HEAD, a branch name, a tag name.

`lotus_path: </path/to/runtime/dir>` (**default**: `/opt/lotus/.lotus`)
- path on target host the `lotus` service should establish as its runtime configuration and data directory.

`lotus_storage_path: </path/to/miner/data-dir>` (**default**: `/opt/lotus/.lotusstorage`)
- path on target host the `lotus-miner` service should establish as its runtime and data storage directory.

`go_autoinstall: <true|false>` (**default**: `false`)
- automatically install the specified version of Go packages and binaries. Useful when installing from source which requires `go` as a part of its build process

`go_url: <path-or-url-to-archive>` (**default**: see `defaults/main.yml`)
- address of a compressed **tar or zip** archive containing `go` binaries or source for compilation. This method technically supports installation of any available version of `go`. Links to official versions can be found [here](https://golang.org/dl/).

`go_install_dir: </path/to/install/dir>` (**default**: `/usr/local`)
- path on target host where the `go` binaries should be extracted to.

#### Config

Configuration of the `lotus` client can be expressed in a config file written in [TOML](https://github.com/toml-lang/toml), a minimal markup language. **Note:** This file can be found under the directory specified by the `LOTUS_PATH` (for the lotus client/service) or `LOTUS_STORAGE_PATH` (for the lotus miner) environment variables. For an idea of the available configuration options, reference this [example](https://gist.github.com/0x0I/dd3e7e4fbb1b9feaf147c216ebfacff0) (installed by default).

_The following variables can be customized to manage the content of this TOML configuration:_

`config: {"<config-section>": {"<section-setting>": "<setting-value>",..},..}` **default**: see `defaults/main.yml`

* Any configuration setting/value key-pair supported by `lotus` should be expressible within the `config` hash and properly rendered within the associated TOML config. Values can be expressed in typical _yaml/ansible_ form (e.g. Strings, numbers and true/false values should be written as is and without quotes).

  Furthermore, configuration is not constrained by hardcoded author defined defaults or limited by pre-baked templating. If the config section, setting and value are recognized by the `lotus` tool, :thumbsup: to define within `config`.

  Keys of the `config` hash represent TOML config sections:
  ```yaml
  config:
    # [TOML Section 'API']
    API: {}
  ```

  Values of `config[<key>]` represent key,value pairs within an embedded hash expressing config settings:
  ```yaml
  config:
    # TOML Section '[API]'
    API:
      # Section setting ListenAddress with value of localhost binding at port 1234
      ListenAddress: "/ip4/127.0.0.1/tcp/1234/http"
  ```

#### Launch

`extra_run_args: <lotus-cli-options>` (**default**: `[]`)
- list of `lotus daemon` commandline arguments to pass to the binary at runtime for customizing launch. Supporting full expression of `lotus daemon`'s [cli](https://gist.github.com/0x0I/53533099efcee8c87a49301e79358a0a), this variable enables the launch to be customized according to the user's specification.

`extra_miner_args: <lotus-miner-cli-options>` (**default**: `[]`)
- list of `lotus-miner run` commandline arguments to pass to the binary at runtime for customizing launch. Supporting full expression of `lotus-miner run`'s [cli](https://gist.github.com/0x0I/71b7a7c25a7f558d4fd9f0ff39a896d6), this variable enables the launch to be customized according to the user's specification.

`custom_unit_properties: <hash-of-systemd-service-settings>` (**default**: `[]`)
- hash of settings used to customize the `[Service]` unit configuration and execution environment of the *Lotus* **systemd** service.

`custom_miner_properties: <hash-of-systemd-service-settings>` (**default**: `[]`)
- hash of settings used to customize the `[Service]` unit configuration and execution environment of the *Lotus Storage Miner* **systemd** service.

##### Example

```yaml
custom_unit_properties:
  Environment: "LOTUS_PATH=/var/data/lotus"
custom_miner_properties:
  Environment: "LOTUS_STORAGE_PATH=/var/data/lotus-miner"
```

To set multiple environment variables, they need to be space-separated:
```yaml
custom_unit_properties:
  Environment: "BELLMAN_CPU_UTILIZATION=0.875 FIL_PROOFS_MAXIMIZE_CACHING=1 FIL_PROOFS_USE_GPU_COLUMN_BUILDER=1"
custom_miner_properties:
  Environment: "BELLMAN_CPU_UTILIZATION=0.875 FIL_PROOFS_MAXIMIZE_CACHING=1 FIL_PROOFS_USE_GPU_COLUMN_BUILDER=1"
```

Reference the [systemd.service](http://man7.org/linux/man-pages/man5/systemd.service.5.html) *man* page for a configuration overview and reference.

#### Uninstall

`perform_uninstall: <true | false>` (**default**: `false`)
- whether to uninstall and remove all artifacts and remnants of this `lotus` installation on a target host (**see**: `handlers/main.yml` for details)

Dependencies
------------

- 0x0i.systemd

Example Playbook
----------------
default example:
```
- hosts: all
  roles:
  - role: 0x0I.lotus
```

install `lotus` from specified *git* source version:
```
- hosts: all
  roles:
  - role: 0x0I.lotus
    vars:
      install_type: source
      git_url: https://github.com/filecoin-project/lotus.git
      git_version: v0.1.1
```

install `lotus` for the `calibration` network; include SHA extensions; include rust; include `lotus-bench`:
```
- hosts: all
  roles:
    - ansible-rustup

- hosts: all
  environment:
    # SHA Extensions
    RUSTFLAGS: "-C target-cpu=native -g"
    FFI_BUILD_FROM_SOURCE: 1
  vars:
    # Path for rust/cargo
    cargo_home: "{{ /home/{{ ansible_env.HOME }}/.cargo }}"
  roles:
    - role: 0x0I.lotus
      vars:
        install_type: source
        include_benchmarks: true
        git_url: https://github.com/filecoin-project/lotus.git
        git_version: ntwk-calibration
        go_autoinstall: true
        go_url: https://dl.google.com/go/go1.15.5.linux-amd64.tar.gz
```

expose `lotus` API/JSON-RPC server on non-loopback (wildcard/*) address
```
- hosts: all
  roles:
  - role: 0x0I.lotus
    vars:
      install_type: archive
      config:
        API:
          ListenAddress: /ip4/0.0.0.0/tcp/1234/http
        LibP2P:
          ListenAddresses: ["/ip4/0.0.0.0/tcp/0", "/ip6/::/tcp/0"]
```

launch `lotus` service and `lotus-miner` agents with custom runtime/storage paths and launch options:
```
- hosts: all
  roles:
  - role: 0x0I.lotus
    vars:
      install_type: source
      lotus_path: /mnt/lotus
      lotus_storage_path: /mnt/lotus/miner
      managed_services: ['lotus', 'lotus-miner']
      config:
        Metrics:
          Nickname: "my_miner"
      extra_run_args: ['--bootstrap']
      extra_miner_args: ['--nosync']
      custom_miner_properties:
        LimitDATA: 1T
```

License
-------

MIT

Author Information
------------------

This role was created in 2019 by O1.IO.
