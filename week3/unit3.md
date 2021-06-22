# Hands-on exercise for week 3 unit 3:<br/>Creating an overview page

## Previous exercise
[Hands-On exercise for week 3 unit 2: Enhancing the analytical list page](unit2.md)

## Video on openSAP.com platform
[Creating an overview page](https://open.sap.com/courses/fiori-ea1/items/29eAHMc92dwl1rZt0xVq7p)

## Introduction


In this unit, you will learn how to create an overview page application. We will be building a **Travel Overview** application using **Guided Development** in **SAP Business Application Studio**.

**Prerequisite: You have performed all previous exercises of this course.**

## Step 1. Generate SAP Fiori elements project with an Overview Page floor plan

We will be using Business Application Studio to create our application. We will start by generating a project for us.


1. Click **Start from template**.

    ![](images/unit3/img_0.png)



2. Click  **SAP Fiori application** from **Select Template and Target Location** Page.

    ![](images/unit3/img_000.png)



3. Click **Start** to go to **Floorplan Selection** page.

    ![](images/unit3/img_001.png)



4. Select **Overview Page** from **Floorplan Selection** page.

    ![](images/unit3/img_002.png)



5. Click **Next**.

    ![](images/unit3/img_003.png)



6. In this step we will select the data source for the project.
    * From **Data source**, select **Connect to an SAP System**.
    * From **System**, select **abap-cloud-default_abap-trial (SCP)**.
    * From **Service**, select **ZUI_FE_BOOKING_######_O2(1) * OData V2**
    * Click **Next**

    ![](images/unit3/img_004.png)
    **Note:** Choose the service you created during week 1 unit 5.


7. Now we will select **Filter entity**. This entity will be used as the main entity type that will be used for the smart filter bar for the application.
    * From **Filter Entity**, select **BookingType**.
    * Click  **Next**.

    ![](images/unit3/img_005.png)



8. In this step, we will provide the rest of the project attributes.
    * Enter **traveloverview** in **Module name**.
    * Enter **Travel Overview** in **Application title**.
    * Enter **sap.fe.demo** in **Application namespace**.
    * Set **Project folder path** to **/home/user/projects**.
    * Click **Finish**.

    ![](images/unit3/img_006.png)
      **Note:** In project folder path '/home/user/projects' is selected. You can choose a different path but make sure to select the same path to create all applications during this course.
   
      **Note.** If selected project folder path is not opened by default, you can do so by going to **File** menu then select **Open Workspace** and choose the selected folder.<br>

## Step 2. Create an analytical card using Guided Development

Let’s start by creating an Analytical card that will help us understand the Daily flight cost. In this analytical card, we’ll be creating a column chart with **FlightPrice** as a measure and **FlightDate** as the dimension. We will also be creating a KPI header with a data point value that will represent the total spending on flights.


1. Click on  **traveloverview** with the right mouse button.

    ![](images/unit3/img_007.png)


2. Click  **SAP Fiori tools - Open Guided Development**
   >⚠️ Firefox currently has a bug that it does not treat subdomains of localhost as secure. When you open "Guided Development" or another tool of the Fiori tools and the tab stays empty please refresh the page by pressing F5 or click the reload button of the browser. After reloading the page the tool should show up.
    
   ![](images/unit3/img_008.png)


3. Click **Add an analytical card to an overview page**

    ![](images/unit3/img_009.png)



4. Click **Start Guide**.

    ![](images/unit3/img_010.png)


### Guided Development Step 1  

We start by generating a UI Chart annotation. In this annotation, we will supply dimension and measure for the chart. We will also define the chart type we are going to use.

1. Select **Booking** as **Entity Type**.

    ![](images/unit3/img_011.png)


2. Now we will provide settings required to generate the UI Chart annotation.
    * Enter **FlightPriceColumn** as **Chart Qualifier**.
    * Enter **Daily Flight Cost** as **Chart Title**.
    * From **Dimension Property**, select **FlightDate**.
    * From **Measure Property**, select **FlightPrice**.
    * From **Chart Type**, select **Column**.
    * Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_012.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.Chart Annotation.
   
   ```
     <Annotation Term="UI.Chart" Qualifier="FlightPriceColumn">
         <Record>
             <PropertyValue Property="Title" String="Daily Flight Cost"/>
             <PropertyValue Property="MeasureAttributes">
                 <Collection>
                     <Record Type="UI.ChartMeasureAttributeType">
                         <PropertyValue Property="Measure" PropertyPath="FlightPrice"/>
                         <PropertyValue Property="Role" EnumMember="UI.ChartMeasureRoleType/Axis1"/>
                     </Record>
                 </Collection>
             </PropertyValue>
             <PropertyValue Property="DimensionAttributes">
                 <Collection>
                     <Record Type="UI.ChartDimensionAttributeType">
                         <PropertyValue Property="Dimension" PropertyPath="FlightDate"/>
                         <PropertyValue Property="Role" EnumMember="UI.ChartDimensionRoleType/Category"/>
                     </Record>
                 </Collection>
             </PropertyValue>
             <PropertyValue Property="ChartType" EnumMember="UI.ChartType/Column"/>
         </Record>
     </Annotation>
   ```
   Generated Annotation

    ![](images/unit3/img_013.png)


3. Click **Next**

    ![](images/unit3/img_014.png)

### Guided Development Step 2

This step is to generate the presentation variant. Presentation variant can be used to define information like sortOrder or groupBy. Since we don’t need it for this card, we can skip this part.

1.  Click **Next**

    ![](images/unit3/img_015.png)


### Guided Development Step 3

In this step we’ll create data point annotation for the KPI header. We will use the **FlightPrice** property to show the data point.

1. From **Entity Type Property**, select **FlightPrice**.

    ![](images/unit3/img_016.png)


2. Enter following in the **DataPoint Parameters** section,
    * Enter **FlightPriceColumnDataPoint** as **DataPoint Qualifier**.
    * Enter **Flight Price** as **DataPoint Title**.
    * Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_017.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.DataPoint Annotation.

     ```
       <Annotation Term="UI.DataPoint" Qualifier="FlightPriceColumnDataPoint">
          <Record Type="UI.DataPointType">
              <PropertyValue Property="Value" Path="FlightPrice"/>
              <PropertyValue Property="Title" String="Flight Price"/>
          </Record>
       </Annotation>
     ```
   Generated Annotation

    ![](images/unit3/img_018.png)


3. Click **Next**

    ![](images/unit3/img_019.png)


### Guided Development Step 4

In this step we will create a navigation from this analytical card to analytical list report application which was developed during previous units by defining UI.Identification annotation.

1. Enter **ToBookingAnalysis** as **Qualifier**

    ![](images/unit3/img_020.png)


2. Here we are creating an **UI.DataFieldForIntentBasedNavigation** annotation.
    * Enter **Booking** as **Semantic Object**.
    * Enter **analysis** as **Action**.
    * Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_021.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.DataFieldForIntentBasedNavigation Annotation.

   ```
    <Annotation Term="UI.Identification" Qualifier="ToBookingAnalysis">
        <Collection>
            <Record Type="UI.DataFieldForIntentBasedNavigation">
                <PropertyValue Property="SemanticObject" String="Booking"/>
                <PropertyValue Property="Action" String="analysis"/>
            </Record>
        </Collection>
    </Annotation>
   ```

   Generated Annotation

   ![](images/unit3/img_022.png)


3. Click **Next**

    ![](images/unit3/img_023.png)



### Guided Development Step 5

We are now on the final step to generate the card manifest settings. Here we will define a unique card id, OData version and use the generated annotations to define the card manifest.

1. Enter **CARD_000** as card ID then select **V2** as the **OData Version**.

    ![](images/unit3/img_024.png)


2. Enter the following for the card,
    * Select **Booking** as **Entity Set**.
    * Enter **Spending On Flights** in **Title**.
    * Select **Chart Annotation Path** as **UI.Chart#FlightPriceColumn**.
    * Select **DataPoint Annotation Path** as **UI.DataPoint#FlightPriceColumnDataPoint**
    * Select **Identification Qualifier** as **UI.Identification#ToBookingAnalysis**.
    * Enter **Total Spending On Flights** in **Value Selection Info**.
   

3. Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_025.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated card manifest setting.

   ```
   "CARD_000": {
       "model": "mainService",
       "template": "sap.ovp.cards.charts.analytical",
       "settings": {
           "title": "Spending On Flights",
           "entitySet": "Booking",
           "dataPointAnnotationPath": "com.sap.vocabularies.UI.v1.DataPoint#FlightPriceColumnDataPoint",
           "valueSelectionInfo": "Total Spending On Flights",
           "chartAnnotationPath": "com.sap.vocabularies.UI.v1.Chart#FlightPriceColumn",
           "identificationAnnotationPath": "com.sap.vocabularies.UI.v1.Identification#ToBookingAnalysis"
       }
   }
   ```

   Generated card configuration:

    ![](images/unit3/img_026.png)



4. Click **Exit Guide**

    ![](images/unit3/img_027.png)



### Preview Application

We have added an analytical card with column chart in our Travel Overview app. Let's previous the application.

1. Click on  **traveloverview** with the right mouse button.

    ![](images/unit3/img_028.png)


2. Click  **Preview Application**

    ![](images/unit3/img_029.png)



3. Click **start fiori run --open 'test/flpSandbox.html#traveloverview-tile**

    ![](images/unit3/img_030.png)



4. Application Preview

    ![](images/unit3/img_1111.png)


## Step 3. Add OData V4 service from Service Manager

In Overview page, you can create cards using OData V4 service as well. We will now add an OData V4 service to our project that was created during Week 1 of the course. Later we will use this OData V4 service to create a table card.

1. Click on  **manifest.json** with the right mouse button.

    ![](images/unit3/img_031.png)


2. Click  **Open Service Manager**

    ![](images/unit3/img_032.png)


3. Click **Add Service**

    ![](images/unit3/img_033.png)


4. Click **Select a service** dropdown

    ![](images/unit3/img_034.png)


5. Click **ZUI_FE_TRAVEL_######_O4 > ZFE_TRAVEL_###### (0001) - odata v4**

    ![](images/unit3/img_035.png)
   **Note.** Choose the OData V4 service you created during week 1 unit 5.
   <br><br>
6. Click **Add**

    ![](images/unit3/img_036.png)

## Step 4. Add Annotation for a Service

We will add a new annotation file for the added OData V4 service.

1. Click **Annotation File Manager**

    ![](images/unit3/img_037.png)


2. Click **Select service** dropdown

    ![](images/unit3/img_038.png)


3. Click  **zui_fe_travel_######_o4**

    ![](images/unit3/img_039.png)


4. Click **Create Local Annotation File**

    ![](images/unit3/img_040.png)


5. Click **Create**

    ![](images/unit3/img_041.png)

      Generated Annotation file in the project:
   ![](images/unit3/img_042.png)
   **Note.** Close the guided development page for the added service to reflect during card creation.

## Step 5. Add a V4 Table Card

Now that we have added an OData V4 service, we will create a table card to display information on travel. We will also create a view switch to display information filtered by travel status.


1. Click on **traveloverview** with the right mouse button.

    ![](images/unit3/img_043.png)


2. Click **SAP Fiori tools - Open Guided Development**

    ![](images/unit3/img_044.png)


3. Click **Add a table card to an overview page**

    ![](images/unit3/img_045.png)



4. Click **Start Guide**

    ![](images/unit3/img_046.png)


### Guided Development Step 1

We will start by creating UI.DataPoint annotation for different travel start dates.

1. Select **zui_fe_travel_######_o4** from **Model** dropdown. Note, you need to close the guided development tab after you added the additional service and reopen it again.

    ![](images/unit3/img_047.png)


2. Select **Travel** from **Entity Type** dropdown.

    ![](images/unit3/img_048.png)


3. Select **BeginDate** from **Entity Type Property**.

    ![](images/unit3/img_049.png)


4. Enter following for the DataPoint Parameters for **Open/In Progress** travel status,
    * Enter **TravelBeginDateOpenInProgress** as **DataPoint Qualifier**.
    * Enter **Open/In Progress Travels** as **DataPoint Title**.
    * Select **Critical** from **DataPoint Criticality** dropdown.
    * Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_050.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.DataPoint Annotation.

   ```
    <Annotation Term="UI.DataPoint" Qualifier="TravelBeginDateOpenInprogress">
        <Record Type="UI.DataPointType">
            <PropertyValue Property="Criticality" EnumMember="UI.CriticalityType/Critical"/>
            <PropertyValue Property="Value" Path="BeginDate"/>
            <PropertyValue Property="Title" String="Open/In Progress Travels" />
        </Record>
    </Annotation>
   ```
   Generated Annotation - Open/In Progress:

    ![](images/unit3/img_051.png)


5. Enter following for the DataPoint Parameters for **Accepted** travel status,
    * Enter **TravelBeginDateAccepted** as **DataPoint Qualifier**.
    * Enter **Accepted Travels** as **DataPoint Title**.
    * Select **Positive** from **DataPoint Criticality** dropdown.
    * Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_052.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.DataPoint Annotation.

   ```
    <Annotation Term="UI.DataPoint" Qualifier="TravelBeginDateAccepted">
        <Record Type="UI.DataPointType">
            <PropertyValue Property="Criticality" EnumMember="UI.CriticalityType/Positive"/>
            <PropertyValue Property="Value" Path="BeginDate"/>
            <PropertyValue Property="Title" String="Accepted Travels" />
        </Record>
    </Annotation>
   ```


6. Enter following for the DataPoint Parameters for **Rejected** travel status,
    * Enter **TravelBeginDateRejected** as **DataPoint Qualifier**.
    * Enter **Rejected Travels** as **DataPoint Title**.
    * Select **Negative** from **DataPoint Criticality** dropdown.
    * Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_053.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.DataPoint Annotation.

   ```
    <Annotation Term="UI.DataPoint" Qualifier="TravelBeginDateRejected">
        <Record Type="UI.DataPointType">
            <PropertyValue Property="Criticality" EnumMember="UI.CriticalityType/Negative"/>
            <PropertyValue Property="Value" Path="BeginDate"/>
        </Record>
    </Annotation>
   ```


7. Click **Next**.

    ![](images/unit3/img_054.png)

### Guided Development Step 2

We have the data point annotation for the beginDate property. Let's start by creating table columns with data field annotation. Line item annotation will reference the data field as the target.


1. Enter the following in New Column Parameters section,
    * Enter **OpenInProgressTravels** as **Qualifier**.
    * Select **Description** from **Property** dropdown.
    * Enter **Travel** as **Label**.
    * Click **Insert Snippet (formerly Apply)**.

    ![](images/unit3/img_055.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.DataField Annotation.

   ```
    <Annotation Term="UI.LineItem" Qualifier="OpenInprogressTravels">
        <Collection>
            <Record Type="UI.DataField">
                <PropertyValue Property="Value" Path="Description"/>
                <PropertyValue Property="Label" String="Travel"/>
            </Record>
        </Collection>
    </Annotation>
   ```

   Generated Annotation:
    ![](images/unit3/img_056.png)


2. Enter the following in New Column Parameters section,
    * Select **LastName** as **Property**.
    * Enter **Customer** as **Label**
    * Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_057.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.DataField Annotation appended to the annotation generated in the last step.

   ```
    <Record Type="UI.DataField">
        <PropertyValue Property="Value" Path="LastName" />
        <PropertyValue Property="Label" String="Customer" />
    </Record>
   ```

   Generated Annotation:
    ![](images/unit3/img_058.png)


3. Clear Property and Label fields. Then select **UI.DataPoint#TravelBeginDateOpenInProgress** as **DataPoint Qualifier** then click **Insert Snippet (formerly Apply)**.

    ![](images/unit3/img_059.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.DataFieldForAnnotation Annotation appended to the annotation generated in the last step.

   ```
    <Record Type="UI.DataFieldForAnnotation">
        <PropertyValue Property="Target" AnnotationPath="@UI.DataPoint#TravelBeginDateOpenInProgress" />
    </Record>
   ```

   Generated Annotation:

    ![](images/unit3/img_060.png)


4. Enter the following in New Column Parameters section,
    * Enter **AcceptedTravels** as **Qualifier**.
    * Select **Description** from **Property** dropdown.
    * Enter **Travel** as **Label**.
    * Click **Insert Snippet (formerly Apply)**.

    ![](images/unit3/img_061.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.DataField Annotation.

   ```
    <Annotation Term="UI.LineItem" Qualifier="AcceptedTravels">
        <Collection>
            <Record Type="UI.DataField">
                <PropertyValue Property="Label" String="Travel" />
                <PropertyValue Property="Value" Path="Description" />
            </Record>
        </Collection>
    </Annotation>
   ```
   Generated Annotation:

    ![](images/unit3/img_062.png)


5. Enter the following in New Column Parameters section,
    * Select **LastName** as **Property**.
    * Enter **Customer** as **Label**
    * Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_063.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.DataField Annotation appended to the annotation generated in the last step.

   ```
    <Record Type="UI.DataField">
        <PropertyValue Property="Value" Path="LastName" />
        <PropertyValue Property="Label" String="Customer" />
    </Record>
   ```

   Generated Annotation:

    ![](images/unit3/img_064.png)


6. Clear Property and Label fields. Then select **UI.DataPoint#TravelBeginDateAccepted** as **DataPoint Qualifier**.

    ![](images/unit3/img_065.png)


7. Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_066.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.DataFieldForAnnotation Annotation appended to the annotation generated in the last step.

   ```
    <Record Type="UI.DataFieldForAnnotation">
        <PropertyValue Property="Target" AnnotationPath="@UI.DataPoint#TravelBeginDateAccepted" />
    </Record>
   ```

   Generated Annotation:

    ![](images/unit3/img_067.png)


8. Enter the following in New Column Parameters section,
    * Enter **RejectedTravels** as **Qualifier**.
    * Select **Description** from **Property** dropdown.
    * Enter **Travel** as **Label**.
    * Click **Insert Snippet (formerly Apply)**.

    ![](images/unit3/img_068.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.DataField Annotation.

   ```
    <Annotation Term="UI.LineItem" Qualifier="RejectedTravels">
        <Collection>
            <Record Type="UI.DataField">
                <PropertyValue Property="Label" String="Travel" />
                <PropertyValue Property="Value" Path="Description" />
            </Record>
        </Collection>
    </Annotation>
   ```

   Generated Annotation:
    ![](images/unit3/img_069.png)


9. Enter the following in New Column Parameters section,
    * Select **LastName** as **Property**.
    * Enter **Customer** as **Label**
    * Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_070.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.DataField Annotation appended to the annotation generated in the last step.

   ```
    <Record Type="UI.DataField">
        <PropertyValue Property="Value" Path="LastName" />
        <PropertyValue Property="Label" String="Customer" />
    </Record>
   ```

   Generated Annotation:

    ![](images/unit3/img_071.png)


10. Clear Property and Label fields. Then select **UI.DataPoint#TravelBeginDateRejected** as **DataPoint Qualifier** then click **Insert Snippet (formerly Apply)**.
   ![](images/unit3/img_072.png)
   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.DataFieldForAnnotation Annotation appended to the annotation generated in the last step.
   
   ```
   <Record Type="UI.DataFieldForAnnotation">
      <PropertyValue Property="Target" AnnotationPath="@UI.DataPoint#TravelBeginDateRejected" />
   </Record>
   ```
   
   Generated Annotation:
   
   ![](images/unit3/img_073.png)


11. Click **Next**

    ![](images/unit3/img_074.png)


### Guided Development Step 3

In this step, we will create 3 selection variants for each status **Accepted**, **Rejected** and **Open/In Progress**.

1. Enter the following in the **Filter Values** section.
    * Enter **OpenInProgressSelection** in **Selection Variant Qualifier**.
    * Select **TravelStatusText** from **Filter Property**.
    * Enter **Open** as **Filter Value**.
    * Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_075.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.SelectionVariant annotation.

   ```
   <Annotation Term="UI.SelectionVariant" Qualifier="OpenInProgressSelection">
      <Record>
          <PropertyValue Property="SelectOptions">
              <Collection>
                  <Record Type="UI.SelectOptionType">
                      <PropertyValue Property="PropertyName" PropertyPath="TravelStatusText" />
                      <PropertyValue Property="Ranges">
                          <Collection>
                              <Record>
                                  <PropertyValue Property="Sign" EnumMember="UI.SelectionRangeSignType/I" />
                                  <PropertyValue Property="Option" EnumMember="UI.SelectionRangeOptionType/EQ" />
                                  <PropertyValue Property="Low" String="Open" />
                              </Record>
                          </Collection>
                      </PropertyValue>
                  </Record>
              </Collection>
          </PropertyValue>
      </Record>
   </Annotation>
   ```

   Generated Annotation:

    ![](images/unit3/img_076.png)


2. Enter **In Progress** in **Filter Value** then click **Insert Snippet (formerly Apply)**.

    ![](images/unit3/img_077.png)

   After clicking on Insert Snippet (formerly Apply), this record will be appended to annotation generated in last step.

   ```
    <Record Type="UI.SelectOptionType">
        <PropertyValue Property="PropertyName" PropertyPath="TravelStatusText" />
        <PropertyValue Property="Ranges">
            <Collection>
                <Record>
                    <PropertyValue Property="Sign" EnumMember="UI.SelectionRangeSignType/I" />
                    <PropertyValue Property="Option" EnumMember="UI.SelectionRangeOptionType/EQ" />
                    <PropertyValue Property="Low" String="In Progress" />
                </Record>
            </Collection>
        </PropertyValue>
    </Record>
   ```
   Generated Annotation:

    ![](images/unit3/img_078.png)


3. Enter the following in the **Filter Values** section.
    * Enter **AcceptedSelection** in **Selection Variant Qualifier**.
    * Select **TravelStatusText** from **Filter Property**.
    * Enter **Accepted** as **Filter Value**.
    * Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_079.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.SelectionVariant annotation.
   ```
   <Annotation Term="UI.SelectionVariant" Qualifier="AcceptedSelection">
      <Record>
         <PropertyValue Property="SelectOptions">
             <Collection>
                 <Record>
                     <PropertyValue Property="PropertyName" PropertyPath="TravelStatusText" />
                     <PropertyValue Property="Ranges">
                         <Collection>
                             <Record>
                                 <PropertyValue Property="Sign" EnumMember="UI.SelectionRangeSignType/I" />
                                 <PropertyValue Property="Option" EnumMember="UI.SelectionRangeOptionType/EQ" />
                                 <PropertyValue Property="Low" String="Accepted" />
                             </Record>
                         </Collection>
                     </PropertyValue>
                 </Record>
             </Collection>
         </PropertyValue>
      </Record>
   </Annotation>
   ```

   Generated Annotation:

    ![](images/unit3/img_080.png)


4. Enter the following in the **Filter Values** section.
    * Enter **RejectedSelection** in **Selection Variant Qualifier**.
    * Select **TravelStatusText** from **Filter Property**.
    * Enter **Rejected** as **Filter Value**.
    * Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_081.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.SelectionVariant annotation.
   ```
    <Annotation Term="UI.SelectionVariant" Qualifier="RejectedSelection">
        <Record>
            <PropertyValue Property="SelectOptions">
                <Collection>
                    <Record>
                        <PropertyValue Property="PropertyName" PropertyPath="TravelStatusText" />
                        <PropertyValue Property="Ranges">
                            <Collection>
                                <Record>
                                    <PropertyValue Property="Sign" EnumMember="UI.SelectionRangeSignType/I" />
                                    <PropertyValue Property="Option" EnumMember="UI.SelectionRangeOptionType/EQ" />
                                    <PropertyValue Property="Low" String="Rejected" />
                                </Record>
                            </Collection>
                        </PropertyValue>
                    </Record>
                </Collection>
            </PropertyValue>
        </Record>
    </Annotation>
   ```
   Generated annotation:

    ![](images/unit3/img_082.png)



5. Click **Next**

    ![](images/unit3/img_083.png)



### Guided Development Step 4


In this step, we will configure navigation to the list report application that we developed during week 1.

1. Enter **ToTravelManage** as **Qualifier**

    ![](images/unit3/img_084.png)


2. Enter the following for the **UI.DataFieldForIntentBasedNavigation** annotation.
    * Enter **Travel** as **Semantic Object**.
    * Enter **manage** as **Action**.
    * Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_085.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated UI.Identification annotation.

   ```
    <Annotation Term="UI.Identification" Qualifier="ToTravelManage">
        <Collection>
            <Record Type="UI.DataFieldForIntentBasedNavigation">
                <PropertyValue Property="SemanticObject" String="Travel"/>
                <PropertyValue Property="Action" String="manage"/>
            </Record>
        </Collection>
    </Annotation>
   ```

   Generated Annotation:

    ![](images/unit3/img_086.png)


3. Click **Next**

    ![](images/unit3/img_087.png)


### Guided Development Step 5

In this step we will provide card manifest settings.

1. Enter the following in the **New Card Parameters** section.
    * Select **Travel** from **Entity Set** dropdown.
    * Enter **CARD_001** as **Card ID**
    * Select **V4** from **OData Version** dropdown.

    ![](images/unit3/img_088.png)


2. Enter the following in the **Table Card Settings Parameters**,
    * Enter **Travel List** as **Title**.
    * Select **Travel** from **Entity Type** dropdown.
    * Select **BeginDate** from **Sort By** dropdown.
    * Select **Ascending** from **Sort Order** dropdown.
    * Select **Yes** from **Tabs** dropdown.
    * Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_089.png)

   After clicking on Insert Snippet (formerly Apply), this would be the generated card setting.

   ```
    "CARD_001": {
        "model": "zui_fe_travel_00
        _o4",
        "template": "sap.ovp.cards.v4.table",
        "settings": {
            "title": "Travel List",
            "entitySet": "Travel",
            "sortOrder": "ascending",
            "sortBy": "BeginDate",
            "tabs": [
                {}
            ]
        }
    }
   ```

   Generated Card Setting:

    ![](images/unit3/img_090.png)


3. Click **Next**

    ![](images/unit3/img_091.png)

### Guided Development Step 6

In this step, we will create tab settings for the view switch.

1. Enter the following in the **Tab Setting Parameters**,
    * Select **UI.LineItem#OpenInProgressTravels** from **LineItem Annotation Path** dropdown.
    * Select **UI.SelectionVariant#OpenInProgressSelection** from **Selection Variant Annotation Path**.
    * Select **UI.Identification#ToTravelManage** from **Identification Qualifier**.
    * Enter **Open/In Progress** as **Value**.
    * Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_092.png)

   After clicking on Insert Snippet (formerly Apply), this would be the tab setting appended to the card tabs setting we generated in Step 5.

   ```
    {
        "annotationPath": "com.sap.vocabularies.UI.v1.LineItem#OpenInProgressTravels",
        "selectionAnnotationPath": "com.sap.vocabularies.UI.v1.SelectionVariant#OpenInProgressSelection",
        "identificationAnnotationPath": "com.sap.vocabularies.UI.v1.Identification#ToTravelManage",
        "value": "Open/In Progress"
    }
   ```

   Generated Tab Settings:

    ![](images/unit3/img_093.png)


2. Enter the following in the **Tab Setting Parameters**,
    * Select **UI.LineItem#AcceptedTravels** from **LineItem Annotation Path** dropdown.
    * Select **UI.SelectionVariant#AcceptedSelection** from **Selection Variant Annotation Path**.
    * Select **UI.Identification#ToTravelManage** from **Identification Qualifier**.
    * Enter **Accepted** as **Value**.
    * Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_094.png)

   After clicking on Insert Snippet (formerly Apply), this would be the tab setting appended to the card tabs setting we generated in Step 5.

   ```
    {
        "annotationPath": "com.sap.vocabularies.UI.v1.LineItem#AcceptedTravels",
        "selectionAnnotationPath": "com.sap.vocabularies.UI.v1.SelectionVariant#AcceptedSelection",
        "identificationAnnotationPath": "com.sap.vocabularies.UI.v1.Identification#ToTravelManage",
        "value": "Accepted"
    }
   ```
   Generated Tab Setting:

    ![](images/unit3/img_095.png)


3. Enter the following in the **Tab Setting Parameters**,
    * Select **UI.LineItem#RejectedTravels** from **LineItem Annotation Path** dropdown.
    * Select **UI.SelectionVariant#RejectedSelection** from **Selection Variant Annotation Path**.
    * Select **UI.Identification#ToTravelManage** from **Identification Qualifier**.
    * Enter **Rejected** as **Value**.
    * Click **Insert Snippet (formerly Apply)**

    ![](images/unit3/img_096.png)

   After clicking on Insert Snippet (formerly Apply), this would be the tab setting appended to the card tabs setting we generated in Step 5.

   ```
    {
        "annotationPath": "com.sap.vocabularies.UI.v1.LineItem#RejectedTravels",
        "selectionAnnotationPath": "com.sap.vocabularies.UI.v1.SelectionVariant#RejectedSelection",
        "identificationAnnotationPath": "com.sap.vocabularies.UI.v1.Identification#ToTravelManage",
        "value": "Rejected"
    }
   ```

   Generated Tab setting

    ![](images/unit3/img_097.png)


4. Click **Exit Guide**

    ![](images/unit3/img_098.png)


### Preview Application

1. Click on **traveloverview** with the right mouse button.

    ![](images/unit3/img_099.png)


2. Click **Preview Application**

    ![](images/unit3/img_0100.png)


3. Click **start fiori run --open 'test/flpSandbox.html#traveloverview-tile**

    ![](images/unit3/img_0101.png)

* Application Preview

    ![](images/unit3/img_201.png)

## Step 6. Adding Text Arrangement for V4 card

Let’s add a text arrangement annotation for the description field. With this annotation the Travel Id with display next to the Description field in the table.

1. Click to open **annotation0.xml**

    ![](images/unit3/img_202.png)


2. Paste the following annotation in the annotation file for the OData V4 service.

   ```
    <Annotations Target="SAP.TravelType/Description">
        <Annotation Term="com.sap.vocabularies.Common.v1.Text" Path="TravelID">
            <Annotation Term="com.sap.vocabularies.UI.v1.TextArrangement" EnumMember="com.sap.vocabularies.UI.v1.TextArrangementType/TextLast" />
        </Annotation>
    </Annotations>
   ```

   Annotation Preview:

    ![](images/unit3/img_203.png)

   Application Preview:

    ![](images/unit3/img_204.png)



## Step 7. Add Selection Field for filter bar fields

Next step would be to configure the smart filter bar to show only the relevant fields to us. We will use Selection Fields annotation on the main entity set applied to the global filter bar to show **CarrierID** and **BookingDate**.  

1. Click to open **annotation.xml**

    ![](images/unit3/img_205.png)


2. Paste the following in the annotation.xml file.

   ```
    <Annotation Term="UI.SelectionFields">
        <Collection>
                <PropertyPath>CarrierID</PropertyPath>
                <PropertyPath>BookingDate</PropertyPath>
        </Collection>
    </Annotation>
   ```

   Add this annotation under **cds_zfe_booking_analytics_######.BookingType** annotations target in your annotation.xml file.
 
   ```
    <Annotations Target="cds_zfe_booking_analytics_######.BookingType">
        ...
    </Annotations>
   ```
  
   Note: We used a slighly different version of **UI.SelectionFields** annotation in the video, which works as well. But this one is the leaner version. 

   Annotation Preview:

    ![](images/unit3/img_206.png)

   Application Preview:

    ![](images/unit3/img_207.png)



## Step 8. Add Link List card (Bonus exercise)

Let's add a Static Linked List card to our app called ‘Quick Links’. Where we can maintain some links that might be useful for a travel desk clerk like, create travel, Manage travel and so on.

Paste this card setting under "cards" property of "sap.ovp" property in the manifest.json file to add the static link list card.

```
    "CARD_002": {
        "model": "mainService",
        "template": "sap.ovp.cards.linklist",
        "settings": {
            "title": "Quick Links",
            "listFlavor": "standard",
            "staticContent": [
                {
                    "title": "Create Travel",
                    "imageUri": "sap-icon://create",
                    "imageAltText": "{{card30_icon_so_man}}",
                    "targetUri": "https://sap.com",
                    "openInNewWindow": true
                },
                {
                    "title": "Manage Travel",
                    "imageUri": "sap-icon://edit",
                    "imageAltText": "{{card30_icon_so_man}}",
                    "targetUri": "https://sap.com",
                    "openInNewWindow": true
                },
                {
                    "title": "Airport Status",
                    "imageUri": "sap-icon://message-information",
                    "imageAltText": "{{card30_icon_so_man}}",
                    "targetUri": "https://sap.com",
                    "openInNewWindow": true
                },
                {
                    "title": "Location Guides",
                    "imageUri": "sap-icon://functional-location",
                    "imageAltText": "{{card30_icon_so_man}}",
                    "targetUri": "https://sap.com",
                    "openInNewWindow": true
                },
                {
                    "title": "Travel Warnings",
                    "imageUri": "sap-icon://alert",
                    "imageAltText": "{{card30_icon_so_man}}",
                    "targetUri": "https://sap.com",
                    "openInNewWindow": true
                },
                {
                    "title": "Rental Car Booking",
                    "imageUri": "sap-icon://car-rental",
                    "imageAltText": "{{card30_icon_so_man}}",
                    "targetUri": "https://sap.com",
                    "openInNewWindow": true
                }
            ]
        }
    }
```

## Step 9. Add Another Analytical card with donut chart (Bonus exercise)

 Let's add another analytical card with donut chart **Spending By Airlines**. This card should display the flight cost by airlines. We will use **FlightPrice** as the measure and **CarrierName** as the dimension. Similar to Spending on flights card, we can configure navigation to the analytical list report application created in previous units.

 UI.Chart Annotation for the card

   ```
     <Annotation Term="UI.Chart" Qualifier="FlightPriceByAirlineDonut">
        <Record>
           <PropertyValue Property="Title" String="Flight Cost By Airlines"/>
           <PropertyValue Property="MeasureAttributes">
               <Collection>
                   <Record Type="UI.ChartMeasureAttributeType">
                       <PropertyValue Property="Measure" PropertyPath="FlightPrice"/>
                       <PropertyValue Property="Role" EnumMember="UI.ChartMeasureRoleType/Axis1"/>
                   </Record>
               </Collection>
           </PropertyValue>
           <PropertyValue Property="DimensionAttributes">
               <Collection>
                   <Record Type="UI.ChartDimensionAttributeType">
                       <PropertyValue Property="Dimension" PropertyPath="CarrierName"/>
                       <PropertyValue Property="Role" EnumMember="UI.ChartDimensionRoleType/Category"/>
                   </Record>
               </Collection>
           </PropertyValue>
           <PropertyValue Property="ChartType" EnumMember="UI.ChartType/Donut"/>
        </Record>
    </Annotation>
   ```
 
Add this annotation under **cds_zfe_booking_analytics_######.BookingType** annotations target in your annotation.xml file.
 
   ```
    <Annotations Target="cds_zfe_booking_analytics_######.BookingType">
        ...
    </Annotations>
   ```
  

Manifest setting for the card,

```
    "CARD_003": {
        "model": "mainService",
        "template": "sap.ovp.cards.charts.analytical",
        "settings": {
            "title": "Spending By Airlines",
            "entitySet": "Booking",
            "identificationAnnotationPath": "com.sap.vocabularies.UI.v1.Identification#ToBookingAnalysis",
            "chartAnnotationPath": "com.sap.vocabularies.UI.v1.Chart#FlightPriceByAirlineDonut"
        }
    }
```



### Preview of the application after adding **Analytical Card** (Donut Chart) and **Static Link List Card**.

![](images/unit3/img_300.png)


## Summary
You have completed the exercise!
In this unit, you have learned

- When to use an overview page
- About the components in an overview page
- How to personalize the overview page
- How to create an overview page

## Next Exercise
[Week 3 Unit 4: Deploying your SAP Fiori elements app](unit4.md)
