# PrestaShop ARM template

This template deploys a simple PrestaShop platform, with one front-end VM and one MySQL VM.

MySQL is automatically installed and configured, using a two-disk striping configuration.

Apache and PHP are then installed on the front-end, and PrestaShop is installed and automatically configured.

Once the installation is finished, you can browse to the public IP or DNS to access the sample store.

To access the administration interface, add `/admin` to the store URL. In order to be able to access the administration interface though, PrestaShop will require you to remove or rename the `installation` folder from the root of the Web server. To do that:

- Log on to the front-end VM using SSH on the public IP
- Go to the Apache web root directory: `cd /var/www/html`
- Rename or remove the directory: `mv install install.old` or `rm -rf install` 

You can then access the administration interface.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FQuetzacoalt91%2Fazure-quickstart-templates%2Fmaster%2Fprestashop%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
