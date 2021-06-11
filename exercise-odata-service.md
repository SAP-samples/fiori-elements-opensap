[![REUSE status](https://api.reuse.software/badge/github.com/SAP-samples/fiori-elements-opensap)](https://api.reuse.software/info/github.com/SAP-samples/fiori-elements-opensap)

# Developing and Extending SAP Fiori Elements Apps openSAP - Sample OData Service

The openSAP course **Developing and Extending SAP Fiori Elements Apps** by default expects you to use the ABAP environment that can be activated in your SAP BTP trial.  

Customers and partners that want to use their own SAP BTP ABAP Environment instance have to install the content of **this repository** as well as the 
**ABAP Flight Reference Scenario for the ABAP RESTful Application Programming Model for SAP BTP ABAP Environment**.

## Prerequisites
Make sure to fulfill the following requirements:
* You have access to an SAP BTP ABAP Environment instance (see [here](https://blogs.sap.com/2018/09/04/sap-cloud-platform-abap-environment) for additional information).
* You have downloaded and installed ABAP Development Tools (ADT). Make sure to use the most recent version as indicated on the [installation page](https://tools.hana.ondemand.com/#abap). 
* You have created an ABAP Cloud Project in ADT that allows you to access your SAP BTP ABAP Environment instance (see [here](https://help.sap.com/viewer/5371047f1273405bb46725a417f95433/Cloud/en-US/99cc54393e4c4e77a5b7f05567d4d14c.html) for additional information). Your log-on language is English.
* You have installed the [abapGit](https://github.com/abapGit/eclipse.abapgit.org) plug-in for ADT from the update site `http://eclipse.abapgit.org/updatesite/`.
* You have installed the [ABAP Flight Reference Scenario for the ABAP RESTful Application Programming Model](https://github.com/SAP-samples/abap-platform-refscen-flight/blob/BTP-ABAP/README.md)

## Download
Use the abapGit plug-in to install the package <em>/DMO/FE_HANDS_ON</em> by executing the following steps:
1. In your ABAP cloud project, create the ABAP package `/DMO/FE_HANDS_ON` (using the superpackage `/DMO/SAP`) as the target package for the demo content to be downloaded (leave the suggested values unchanged when following the steps in the package creation wizard). **Please mark the checkbox "Add to favorite packages".**
2. To add the <em>abapGit Repositories</em> view to the <em>ABAP</em> perspective, click `Window` > `Show View` > `Other...` from the menu bar and choose `abapGit Repositories`.
3. In the <em>abapGit Repositories</em> view, click the `+` icon to clone an abapGit repository.
4. Enter the following URL of this repository: `https://github.com/SAP-samples/fiori-elements-opensap.git` and choose <em>Next</em>.
5. Select the default branch <em>BTP-ABAP</em> and enter the newly created package `/DMO/FE_HANDS_ON` as the target package and choose <em>Next</em>.
6. Create a new transport request that you only use for this demo content installation (recommendation) and choose <em>Finish</em> to link the Git repository to your ABAP cloud project. The repository appears in the abapGit Repositories View with status <em>Linked</em>.
7. Right-click on the new ABAP repository and choose `pull` to start the cloning of the repository contents. Note that this procedure may take a few minutes. 
8. Once the cloning has finished, the status is set to `Pulled Successfully`. (Refresh the `abapGit Repositories` view to see the progress of the import). Then refresh your project tree. 

As a result of the installation procedure above, the ABAP system creates an inactive version of all artifacts from the demo content and adds the following sub repository objects to the target package: 
* Data Element: `/DMO/CARRIER_PIC`
* CLASS `/dmo/cl_fe_travel_generator` 

## Configuration

To activate all development objects from the `/DMO/FE_HANDS_ON` package: 
1. Click the mass-activation icon (<em>Activate Inactive ABAP Development Objects</em>) in the toolbar.  

> **NOTE:** 
> The namespace **/DMO/** is reserved for the demo content. Apart from the downloaded demo content, do not use the namespace /DMO/ and do not create any development objects in the downloaded packages. You can access the development objects in /DMO/ from your own namespace.

## Generate Exercise Service
See [Hands-on exercise for week 1 unit 5: Creating an OData service with ABAP RESTful Application Programming Model](week1/unit5.md)

## How to obtain support
This project is provided "as-is": there is no guarantee that raised issues will be answered or addressed in future releases.

## License
Copyright (c) 2018-2020 SAP SE or an SAP affiliate company. All rights reserved.
This project is licensed under the SAP Sample Code License except as noted otherwise in the [LICENSE](LICENSES/Apache-2.0.txt) file.


