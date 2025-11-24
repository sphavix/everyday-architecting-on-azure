### Lab Prerequisites
In order to complete this lab, you will need the following:
- Microsoft Edge/Chrome/Firefox
- File Explorer
- Terminal
- Visual Studio Code

### Lab Scenario
In this lab, you will explore how to create a web application on Azure by using the PaaS model. After the web application is created, you will learn how to upload existing web application files by using the Apache Kudu zip deployment option. You will then view and test the newly deployed web application.

#### Architecture Diagram
![](https://github.com/sphavix/everyday-architecting-on-azure/blob/main/implement-az-app-svc/Lab001/Images/Lab01-Diagram.png)


### Exercise 1: Build a backend API by using Azure Storage and the Web Apps feature of Azure App Service
--------------------------------------------------------------------------------------------------------
### Task 1: Open the Azure portal
On the taskbar, select the Microsoft Edge icon.

In the browser window, browse to the Azure portal at https://portal.azure.com, and then sign in with the account you'll be using for this lab.

Note: If this is your first time signing in to the Azure portal, you'll be offered a tour of the portal. If you prefer to skip the tour, select Maybe later to begin using the portal.

### Task 2: Create a Storage account
1. In the Azure portal, use the Search resources, services, and docs text box to search for Storage Accounts, and then in the list of results, select Storage Accounts.

2. On the **Storage accounts** blade, select **+ Create**.

3. On the **Create a storage account** blade, on the **Basics** tab, perform the following actions, and then select **Review + create**:

|Setting	                   |         Action                             |
|----------------------------|----------------------------------------------|
|**Subscription** drop-down list |	Retain the default value.|
|**Resource group** section 	   |  Select existing **ManagedPlatform-lod56893793** or your own resource group name.|
|**Storage account** name text box   |  enter **imgstor56893793** |
|**Region** drop-down list	     |  Select **(US) East US** |
|**Primary service**	           |  No changes |
|**Performance** section	       |  Select the **Standard** option |
|**Redundancy** drop-down list	 |  Select **Locally-redundant storage (LRS)**|


4. On the **Review + create** tab, review the options that you selected during the previous steps.

5. Select **Create** to create the storage account by using your specified configuration.

**Note:** Wait for the creation task to complete before you proceed with this lab.

6. On the **Overview** blade, select the **Go to resource** button to navigate to the blade of the newly created storage account.

7. On the **Storage account** blade, in the **Security + networking** section, select **Access keys**.

8. On the **Access keys** blade, review any one of the **Connection string** (using **Show** button), and then record the value of either **Connection string** boxes in Notepad. The **Keys** are platform managed encryption keys and are not used for this lab.

**Note:** It doesn't matter which connection string you choose. They are interchangeable.

9. Open Notepad, and then paste the copied connection string value to Notepad. You'll use this value later in this lab.

### Task 3: Upload a sample blob
1. On the **Storage Account** blade, in the **Data storage** section, select the **Containers** link.

2. On the **Containers** blade, select **+ Container**.

3. In the **New container** window, perform the following actions, and then select **Create**.

|Setting	                |    Action        |
|-------------------------|------------------|
|Name text box	          |   enter images   |

4. On the **Containers** blade, navigate into the newly created **images** container.

5. On the **images** blade, select **Upload**.

6. In the **Upload blob** window, perform the following actions:

|Setting	                                  |       Action                                                    |
|-------------------------------------------|-----------------------------------------------------------------|
|**Files** section	                        | Select Browse for files or use the drag and drop feature        |
|**File Explorer** window	                  |Browse to cloned repo **C:\implement-az-app-svc\Lab001\Images**, select the **grilledcheese.jpg** file, and then select **Open**|
|**Overwrite if files already exist** check box |	Ensure that the check box is selected, and then select **Upload**|

**Note:** Wait for the blob to upload before you continue with this lab.

#### Task 4: Create a web app
1. On the Azure portal's navigation pane, select **Create a resource**.

2. On the **Create a resource** blade, in the **Search services and marketplace** text box, enter **Web App**, and then select **Enter**.

3. On the **Marketplace** search results blade, select the **Web App** result.

4. On the **Web App** blade, select **Create**.

5. On the **Create Web App** blade, on the **Basics** tab, perform the following actions, and then select the **Monitor + secure** tab:

|Setting	                                      |  Action        |
|-----------------------------------------------|----------------|
|**Subscription** drop-down list	                  |Retain the default value|
|**Resource group** section	                        |Select **ManagedPlatform-lod56893793** or your resource group name|
|**Name** text box	                                |enter **imgapi56893793**|
|**Secure unique default hostname**	                |**Disabled**|
|**Publish** section	                              |Select **Code**|
|**Runtime stack** drop-down list	                  |Select **.NET 8 (LTS)**|
|**Operating System** section	                      |Select **Windows**|
|**Region** drop-down list	                        |Select the **East US** region|
|**Windows Plan (East US)** section	                |Select **Create new**, enter the value **ManagedPlan** in the Name text box, and then select **OK**|
|**Pricing plan** section	                          |Select **Standard S1**|

The following screenshot displays the configured settings on the Create web app blade.

Create web app blade

On the Monitor + secure tab, in the Enable Application Insights section, select No, and then select Review + create.

On the Review + create tab, review the options that you selected during the previous steps.

Select Create to create the web app by using your specified configuration.

Note: Wait for the web app to be created before you continue with this lab.

On the Overview blade, select the Go to resource button to navigate to the blade of the newly created web app.

Task 5: Configure the web app
On the App Service blade, in the Settings section, select the Environment variables link.

In the App settings tab, select + Add. Enter the following information in the Add/Edit application setting pop-up dialog:

Setting	Action
Name text box	enter StorageConnectionString
Value text box	Paste the storage connection string that you previously copied to Notepad
Deployment slot setting check box	Retain the default value
Select Apply to close the pop-up dialog and return to the App settings section.

At the bottom of the App settings section, select Apply.

Note: You may receive a warning that your app may restart when updating app settings. Select Confirm. Wait for your application settings to save before you continue with the lab.

To get the App Service's URL, go to the Overview link, copy the value from the Default domain section, and then paste it to Notepad. Prepend https:// to the domain name in Notepad. You’ll use this value later in the lab.

Note: At this point, the web server at this URL will return a placeholder webpage. You haven't deployed any code to the Web App yet. You'll deploy code to the Web App later in this lab.

Task 6: Deploy an ASP.NET web application to Web Apps
On the taskbar, select the Visual Studio Code icon.

On the File menu, select Open Folder.

In the File Explorer window, browse to Allfiles C:\Allfiles\Labs\01\Starter\API, and then select Select Folder.

Note: Ignore any prompts to add required assets to build and debug and to run the restore command to address unresolved dependencies.

On the Explorer pane of the Visual Studio Code window, expand the Controllers folder, and then select the ImagesController.cs file to open the file in the editor.

In the editor, in the ImagesController class on line 26, observe the GetCloudBlobContainer method and the code used to retrieve a container.

In the ImagesController class on line 36, observe the Get method and the code used to retrieve all blobs asynchronously from the images container.

In the ImagesController class on line 68, observe the Post method and the code used to persist an uploaded image to Storage.

On the taskbar, select the Terminal icon.

At the open terminal, enter the following command, and then select Enter to sign in to the Azure Command-Line Interface (CLI):

TypeCopy
az login
In the Microsoft Edge browser window, enter the email address and password for your Microsoft account, and then select Sign in.

Return to the currently open Terminal window. Wait for the sign-in process to finish.

Within the terminal, enter the following command, and then select Enter to list all the apps in your ManagedPlatform-lod56893793 resource group:

TypeCopy
az webapp list --resource-group ManagedPlatform-lod56893793
Enter the following command, and then select Enter to find the apps that have the imgapi* prefix:

TypeCopy
az webapp list --resource-group ManagedPlatform-lod56893793 --query "[?starts_with(name, 'imgapi')]"
Enter the following command, and then select Enter to render only the name of the single app that has the imgapi* prefix:

TypeCopy
az webapp list --resource-group ManagedPlatform-lod56893793 --query "[?starts_with(name, 'imgapi')].{Name:name}" --output tsv
Enter the following command, and then select Enter to change the current directory to the Allfiles C:\Allfiles\Labs\01\Starter\API directory that contains the lab files:

TypeCopy
cd C:\Allfiles\Labs\01\Starter\API\
Enter the following command, and then select Enter to deploy the api.zip file to the web app that you created previously in this lab:

TypeCopy
az webapp deployment source config-zip --resource-group ManagedPlatform-lod56893793 --src api.zip --name <name-of-your-api-app>
Note: Replace the \ placeholder with the name of the web app that you created previously in this lab. You recently queried this app’s name in the previous steps.

Wait for the deployment to complete before you continue with this lab.

On the Azure portal's navigation pane, select the Resource groups link.

On the Resource groups blade, select the ManagedPlatform-lod56893793 resource group that you created previously in this lab.

On the ManagedPlatform-lod56893793 blade, select the imgapi56893793 web app that you created previously in this lab.

From the App Service blade, select Browse.

Note: The Browse command will perform a GET request to the root of the website, which returns a JavaScript Object Notation (JSON) array. This array should contain the URL for your single uploaded image in your Storage account.

Return to your browser window that contains the Azure portal.

Close the currently running Visual Studio Code and Terminal applications.

Review
In this exercise, you created a web app in Azure, and then deployed your ASP.NET web application to Web Apps by using the Azure CLI and Apache Kudu zip file deployment utility.

Exercise 2: Build a front-end web application by using Azure Web Apps
Task 1: Create a web app
On the Azure portal's navigation pane, select Create a resource.

On the Create a resource blade, in the Search services and marketplace text box, enter Web App, and then select Enter.

On the Marketplace search results blade, select Web App.

On the Web App blade, select Create.

On the Create Web App blade, on the Basics tab, perform the following actions, and then select the Monitor + secure tab:

Setting	Action
Subscription drop-down list	Retain the default value
Resource group section	Select ManagedPlatform-lod56893793
Name text box	enter imgweb56893793
Secure unique default hostname	Disabled
Publish section	Select Code
Runtime stack drop-down list	Select .NET 8 (LTS)
Operating System section	Select Windows
Region drop-down list	Select the East US region
Windows Plan (East US) section	Select ManagedPlan (S1)
The following screenshot displays the configured settings on the Create web app blade.

Create web app blade

On the Monitor + secure tab, in the Enable Application Insights section, select No, and then select Review + create.

From the Review + create tab, review the options that you selected during the previous steps.

Select Create to create the web app by using your specified configuration.

Note: Wait for the creation task to complete before you continue with this lab.

On the Overview blade, select the Go to resource button to navigate to the blade of the newly created web app.

Task 2: Configure a web app
On the App Service blade, in the Settings section, select the Environment variables link.

In the Environment variables section, perform the following actions, select Apply, and then select Continue:

Setting	Action
App settings tab	Select New application setting
Add/Edit application setting pop-up dialog	In the Name text box, enter ApiUrl
Value text box	Enter the web app URL that you copied previously in this lab. Note: Make sure you include the protocol https://, in the URL that you copy into the Value text box for this application setting
Deployment slot setting check box	Retain the default value, and then select OK
Click Apply in the top menu	This will save the configuration value you just entered
Note: Wait for the application settings to save before you continue with this lab.

Task 3: Deploy an ASP.NET web application to Web Apps
On the taskbar, select the Visual Studio Code icon.

On the File menu, select Open Folder.

In the File Explorer window, browse to Allfiles C:\Allfiles\Labs\01\Starter\Web, and then select Select Folder.

Note: Ignore any prompts to add required assets to build and debug and to run the restore command to address unresolved dependencies.

On the Explorer pane of the Visual Studio Code window, expand the Pages folder, and then select the Index.cshtml.cs file to open the file in the editor.

In the editor, in the IndexModel class on line 30, observe the OnGetAsync method and the code used to retrieve the list of images from the API.

In the IndexModel class on line 41, observe the OnPostAsync method and the code used to stream an uploaded image to the backend API.

On the taskbar, select the Terminal icon.

At the open terminal, enter the following command, and then select Enter to sign in to the Azure CLI:

TypeCopy
az login
In the Microsoft Edge browser window, enter the email address and password for your Microsoft account, and then select Sign in.

Return to the currently open Terminal window. Wait for the sign-in process to finish.

Enter the following command, and then select Enter to list all the apps in your ManagedPlatform-lod56893793 resource group:

TypeCopy
az webapp list --resource-group ManagedPlatform-lod56893793
Enter the following command, and then select Enter to find the apps that have the imgweb* prefix:

TypeCopy
az webapp list --resource-group ManagedPlatform-lod56893793 --query "[?starts_with(name, 'imgweb')]"
Enter the following command, and then select Enter to render only the name of the single app that has the imgweb* prefix:

TypeCopy
az webapp list --resource-group ManagedPlatform-lod56893793 --query "[?starts_with(name, 'imgweb')].{Name:name}" --output tsv
Enter the following command, and then select Enter to change the current directory to the Allfiles C:\Allfiles\Labs\01\Starter\Web directory that contains the lab files:

TypeCopy
cd C:\Allfiles\Labs\01\Starter\Web\
Enter the following command, and then select Enter to deploy the web.zip file to the web app that you created previously in this lab:

TypeCopy
az webapp deployment source config-zip --resource-group ManagedPlatform-lod56893793 --src web.zip --name <name-of-your-web-app>
Note: Replace the \ placeholder with the name of the web app that you created previously in this lab. You recently queried this app’s name in the previous steps.

Wait for the deployment to complete before you continue with this lab.

On the Azure portal's navigation pane, select Resource groups.

On the Resource groups blade, select the ManagedPlatform-lod56893793 resource group that you created previously in this lab.

On the ManagedPlatform-lod56893793 blade, select the imgweb56893793 web app that you created previously in this lab.

On the App Service blade, select Browse.

Observe the list of images in the gallery. The gallery should list a single image that was uploaded to Storage previously in the lab.

In the Contoso Photo Gallery webpage, in the Upload a new image section, perform the following actions:

Select Browse.

In the File Explorer window, browse to Allfiles C:\Allfiles\Labs\01\Starter\Images, select the banhmi.jpg file, and then select Open.

Select Upload.

Observe that the list of gallery images has updated with your new image.

Note: In some rare cases, you might need to refresh your browser window to retrieve the new image.

Return to the browser window that contains the Azure portal.

Close the currently running Visual Studio Code and Terminal applications.
