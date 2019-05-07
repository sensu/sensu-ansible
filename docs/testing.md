# Testing
This Ansible role makes use of the [molecule](https://github.com/metacloud/molecule)
testing framework to run automatic integration tests for every change.

Molecule is using Python 2.7 with the latest stable release of Ansible to deploy this
Ansible role. After succesfully deploying the entire role, Molecule then uses
[Inspec](https://www.inspec.io/) to perform a set of tests against the final
containers. This ensures that for every supported operating system, the end result
is what we expect.

All changes submitted via [Pull Requests](https://github.com/sensu/sensu-ansible/pulls)
are blocked from merging until the integration tests pass.

## Testing locally
In order to speed up local development, you may opt to locally run the integration
tests to more quickly iterate on new features.

### Local environment prep
1. Fork the [sensu-ansible](https://github.com/sensu/sensu-ansible) repository
2. `git clone` your fork of the `sensu-ansible` repository and `cd` into your local clone.
3. Add the `upstream` repo to your local clone of the repository with the following `git` command:
```bash
git remote add upstream https://github.com/sensu/sensu-ansible.git
```
4. Execute `git checkout -b feature/NEW_FEATURE_NAME_HERE` to work on a dedicated branch
5. Ensure you have a recent version of Docker installed locally: https://docs.docker.com/install/
6. Ensure you have [pipenv](https://docs.pipenv.org/install/#installing-pipenv) installed.
7. Install this repositories development dependacies with `pipenv install --two --dev` followed by ` gem install rubocop`
8. Execute the full integration tests for your chosen operating system distribution: ` pipenv run molecule test --scenario-name $OS --driver-name docker --destroy always`

##### Notes:
1. Currently, you can set `$OS` above to one of `debian`, `ubuntu`, `centos`, `fedora`, `amazonlinux`, or `oraclelinux`.
2. It's faster to iterate by changing `--destroy always` to `--destroy never` such that you don't have to full rebuild the testing infrastructure.
3. If you want to limit testing to just the Inspec unit tests, you can simply run `pipenv run molecule verify --scenario-name $OS` to re-run those steps.
