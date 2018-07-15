# :radioactive: subinstance

>**subinstance** is an example of using Terraform with AWS as provider

This project use [Terraform](https://terraform.io) to provide an instance on Amazon AWS.

## First steps

Clone the project with the command below and then follow the next steps to configure your environment.
```console
$ git clone git@github.com:jeanaugustoos/subinstance.git
```

### AWS
Before starting, we have to follow some steps to be able to interact with AWS Services. After [installing aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/installing.html), we have to set it up with the `aws configure` command.
```console
$ aws configure
AWS Access Key ID [None]:
AWS Secret Access Key [None]:
Default region name [None]:
Default output format [None]:
```
AWS Access Key ID and AWS Secret Access Key are the account credentials and we can check how to get them [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html).

The next step is create a **Key-Pair** called `master-key`, save our private key file and set its permissions so that only we can read it.
```console
$ aws ec2 create-key-pair --key-name master-key --query 'KeyMaterial' --output text > master-key.pem
$ chmod 400 master-key.pem
```

### Terraform

Now, we have to install Terraform. [Here](https://www.terraform.io/intro/getting-started/install.html) is the official way of how to install in your OS. Once that we have finished the instructions we can run `terraform` and we  should see help output similar to this:
```console
$ terraform
Usage: terraform [--version] [--help] <command> [args]

The available commands for execution are listed below.
The most common, useful commands are shown first, followed by
less common or more advanced commands. If you're just getting
started with Terraform, stick with the common commands. For the
other commands, please read the help and docs before usage.

Common commands:
    apply              Builds or changes infrastructure
    console            Interactive console for Terraform interpolations
# ...
```

## Create your infrastructure

The first command to run is responsable to initialize the settings that will be used by the next steps.
```console
$ terraform init
```

Before applying the changes we can check the execution plan:
```console
$ terraform plan
```

Finally, to create our infrastructure and check it out on AWS, we have to **apply** our configurations.
```console
$ terraform apply
```

When asked for approval, type `yes` to proceeding.

_**Note:** On Terraform versions bellow 0.11 we must have to run `terraform plan` before `terraform apply`._


## Checking the instance

We can get the Public Dns Name to access our instance with the aws-cli.
```console
$ aws ec2 describe-instances --filters "Name=instance-type,Values=t2.micro" --query Reservations[].Instances[].PublicDnsName
[
    "ec2-XXX.compute-1.amazonaws.com",
    ""
]
```

Now, with this information it's just run the command bellow and we will access our instance.
```console
$ ssh -i master-key.pem ubuntu@ec2-XXX.compute-1.amazonaws.com
Welcome to Ubuntu 16.04.2 LTS (GNU/Linux 4.4.0-66-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

0 packages can be updated.
0 updates are security updates.



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@ip-172-31-86-248:~$
```

That's all folks! :rocket:
