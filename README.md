# gitlab-ci-ssh

[![Image size](https://img.shields.io/docker/image-size/yurihs/gitlab-ci-ssh/latest)](https://hub.docker.com/r/yurihs/gitlab-ci-ssh)

This image is meant to be used in a GitLab CI job.

It allows you to set up an SSH client so you can deploy to a remote server more easily.


## Usage

Your `.gitlab-ci.yml` should be something like this:


```yaml
image: yurihs/gitlab-ci-ssh:1

stages:
  - deploy

deploy_prod:
  stage: deploy
  only:
    - master
  script:
  	- . setup-ssh --host example.com --user myuser --private-key "$SSH_PRIVATE_KEY" --host-key "$SSH_HOST_KEY"
  	- ssh remote your-command-here
```

Then configure the environment variables (`SSH_PRIVATE_KEY`, `SSH_HOST_KEY`) over at `Settings > CI/CD > Variables`.

The private key should not require a password, because you won't have the opportunity to type it in.

The `--host-key` argument is optional, but highly recommended
to protect against man-in-the-middle attacks, and DNS spoofing.
You can get the host key for your server by running `ssh-keyscan` against it from your local machine.


## Advanced usage

Here is the full documentation for the `setup-ssh` script:

```sh
Required arguments:
    --host <hostname>
    --user <username>
    --private-key <private-key>

Optional arguments:
    --port <port>         defaults to 22
    --host-key <host-key> will do a keyscan if not provided
    --local-name <name>   nickname written to SSH config. defaults to "remote"
    --help                you are here
```
