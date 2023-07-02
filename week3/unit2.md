# Hands-on exercise for week 3 unit 2:<br/>Enhancing an Analytical List Page
## Previous exercise
[Hands-on exercise for week 3 unit 1: Creating an Analytical List Page](../week3/unit1.md)

## Video on openSAP.com platform
[Enhancing an analytical list page](https://open.sap.com/courses/fiori-ea1/items/78OF29q3pEXrBgYMmwxR4)

## Introduction
In this unit, you will learn how to enhance the Analytical List Page application created in the previous unit by adding filtering capabilities.
In this exercise, you will define the filter area of the Analytical List Page using the guided development tool.

## Step 1. Configuring the Compact Filters 
The first step you will configure a UI.SelectionFields annotation that is used to display the filter fields in the compact filter bar of the Analytical List Page.
For this, you first have to open the guided development tool.

1. To open the guided development tool right click on the **webapp** folder.

    ![](images/unit2/img_0.png)


2. Click on **SAP Fiori tools - Open Guided Development**. 

    ![](images/unit2/img_000.png)


3. To find the guides related to filters, type **filter** in the search field.

    ![](images/unit2/img_001.png)


4. Scroll to the Analytical List Page group and expand the guide **Add a new filter field to the Filter Bar**.

    ![](images/unit2/img_002.png)


5. Click **Start Guide**.

    ![](images/unit2/img_003.png)

    This simple guide contains just one step adding a field (UI Selection Fields) to your compact filter bar. 


6. In the field **Entity Type**, choose your entity type as: **BookingType**.

    ![](images/unit2/img_004.png)
    
    ![](images/unit2/img_005.png)


7. In the field **Property**, choose **CurrencyCode** as your first column content. <br>

    ![](images/unit2/img_006.png)

    ![](images/unit2/img_007.png)

    The code snippet is adjusted accordingly. <br>


8. Click **Insert Snippet**.

    ![](images/unit2/img_008.png)
    <br>
    The annotation UI.SelectionFields is added to your local annotation file as configured in the code snippet. This file gets opened next to the guided development tool.

    ![](images/unit2/img_009.png) <br>


9. The above step is repeated as many as times as needed to add other filters to the filter bar.

    Choose **AgencyID**  and click **Insert Snippet**.

    Choose **AgencyName** and click **Insert Snippet**.

    Choose **CarrierID** and click **Insert Snippet**.

    Choose **CarrierName** and click **Insert Snippet**.

    Choose **CustomerID** and click **Insert Snippet**.

    Choose **CustomerName** and click **Insert Snippet**.

    Choose **BookingDate** and click **Insert Snippet**.

    Choose **BookingDateYear** and click **Insert Snippet**.
    
    Now we can see the UI.SelectionFields annotation for all the filters is added to your local annotation file as shown in the code snippet below.

    ```
    <Annotation Term="UI.SelectionFields">
        <Collection>
            <PropertyPath>CurrencyCode</PropertyPath>
            <PropertyPath>AgencyID</PropertyPath>
            <PropertyPath>AgencyName</PropertyPath>
            <PropertyPath>CarrierID</PropertyPath>
            <PropertyPath>CarrierName</PropertyPath>
            <PropertyPath>CustomerID</PropertyPath>
            <PropertyPath>CustomerName</PropertyPath>
            <PropertyPath>BookingDate</PropertyPath>
            <PropertyPath>BookingDateYear</PropertyPath>
        </Collection>
    </Annotation>      
    ```

10. When the records for all property are added to your LineItem, click **Exit Guide** to get back to the list of available guides.

    ![](images/unit2/img_018.png)


## Step 2. Preview the application to view the compact filters 

1. Right click **webapp folder**.

    ![](images/unit2/img_019.png)


2. Click on **Preview Application**.

    ![](images/unit2/img_020.png)


3. Click on **start fiori run --open 'test/flpSandbox.html#bookinganalysis-tile'**.

    ![](images/unit2/img_021.png)


4. To view the application in a new browser tab click **Open** in the dialog.

    ![](images/unit2/img_022.png)


5. The visual filters are set as the default filter mode in the Analytical List Page application. To view the compact filters click  ![](images/unit2/fieldicon_20.png) (Filter Toogle for compact filters)

    ![](images/unit2/img_023.png)


6. To view the chart and table click : **Go**.

    ![](images/unit2/img_024.png)


7. We could now see the Analytical List Page application loaded with the chart and the table data.

    ![](images/unit2/img_025.png)


## Step 3. Configuring the visual filters of type line

In this step, you will configure a UI.Chart, UI.PresentationVariant and Common.ValueList annotations that are used to display the visual filters. 

1. Expand the guide **Add a new visual filter** in the Analytical List Page group.

    ![](images/unit2/img_026.png)


2. Click **Start Guide**.

    ![](images/unit2/img_027.png)


3. **Visual Filter Guide(Step 1) - To configure a UI.Chart annotation** 

    At first, you define a chart to be displayed in the filter bar, using a UI.Chart annotation.<br>
   
    In the Entity Type field, choose your entity type as : **BookingType**. 

    ![](images/unit2/img_028.png)

    Enter the following values in the respective fields and click **Insert Snippet**.

    | **Field**             |**Value**
    | --------------------- |----------------------------------
    | Chart Qualifier       |FilterFlightPriceBookingDateYear
    | Chart Title           |Filter FlightPrice by BookingDateYear
    | Chart Description     |Filter FlightPrice by BookingDateYear
    | ChartType             |Line
    | Dimensions Property   |BookingDateYear
    | Measures property     |FlightPrice

    ![](images/unit2/img_029.png)

    The UI.Chart Annotation is now added to the annotation file.  

    Click **Step 2** <br/>
    Note: You can also click **Next** at the bottom of the guide to go to the next step.

    ![](images/unit2/img_031.png)


4. **Visual Filter Guide(Step 2) - To configure a UI.PresentationVariant annotation** 

    In this step, you will reference the chart in a presentation variant so that it could be displayed it in the filter bar.

    Enter the following values and click **Insert Snippet**.

    |**Field**                        |**Value**
    |-------------------------------- |----------------------------------
    |Presentation Variant Qualifier   |PVFilterFlightPriceBookingDateYear
    |Chart Reference                  |\@UI.Chart\#FilterFlightPriceBookingDateYear

    ![](images/unit2/img_033.png)

    The UI.PresentationVariant Annotation is now added to the annotation file.  
    
    Click **Step 3**.

    ![](images/unit2/img_034.png)


5. **Visual Filter Guide(Step 3) - To configure a ValueList annotation** : 

    In that step, you will define the mapping between dimensions in the visual filter and properties in the objects displayed in the main content, so that clicking on a dimension value the visual filter will filter the main content accordingly.For this, we use the Common.ValueList annotation.

    Enter the following values in the respective fields and click **Insert Snippet**.

    |**Field**                        |**Value**
    |-------------------------------- |------------------------------------
    |Entity Type                      |BookingType
    |Entity Type Property             |BookingDateYear
    |Collection Path                  |Booking
    |Presentation Variant Qualifier   |PVFilterFlightPriceBookingDateYear
    |Local Data Property              |BookingDateYear
    |Value List Property              |BookingDateYear

    ![](images/unit2/img_036.png)

    The Common.ValueList Annotation is now added to the annotation file.

    ![](images/unit2/img_037.png)


6. Click **Exit Guide** to get back to the Guides.

    ![](images/unit2/img_038.png)

    Now we can see the UI.Chart and UI.PresentationVariant and common.valuelist annotation is added to your local annotation file as configured in the code snippet below.

    ```
    <Annotation Term="UI.Chart" Qualifier="FilterFlightPriceBookingDateYear">
        <Record Type="UI.ChartDefinitionType">
            <PropertyValue Property="Title" String="Filter FlightPrice By BookingDateYear"/>
            <PropertyValue Property="Description" String="Filter FlightPrice By BookingDateYear "/>
            <PropertyValue Property="ChartType" EnumMember="UI.ChartType/Line"/>
            <PropertyValue Property="Dimensions">
                <Collection>
                    <PropertyPath>BookingDateYear</PropertyPath>
                </Collection>
            </PropertyValue>
            <PropertyValue Property="Measures">
                <Collection>
                    <PropertyPath>FlightPrice</PropertyPath>
                </Collection>
            </PropertyValue>
        </Record>
    </Annotation>
    <Annotation Term="UI.PresentationVariant" Qualifier="PVFilterFlightPriceBookingDateYear">
        <Record Type="UI.PresentationVariantType">
            <PropertyValue Property="Visualizations">
                <Collection>
                    <AnnotationPath>@UI.Chart#FilterFlightPriceBookingDateYear</AnnotationPath>
                </Collection>
            </PropertyValue>
        </Record>
    </Annotation>
   ```
   ```
    <Annotations Target="cds_zfe_booking_analytics_######.BookingType/BookingDateYear">
        <Annotation Term="Common.ValueList">
            <Record Type="Common.ValueListType">
                <PropertyValue Property="CollectionPath" String="Booking"/>
                <PropertyValue Property="PresentationVariantQualifier" String="PVFilterFlightPriceBookingDateYear"/>
                <PropertyValue Property="Parameters">
                    <Collection>
                        <Record Type="Common.ValueListParameterInOut">
                            <PropertyValue Property="LocalDataProperty" PropertyPath="BookingDateYear"/>
                            <PropertyValue Property="ValueListProperty" String="BookingDateYear"/>
                        </Record>
                    </Collection>
                </PropertyValue>
            </Record>
        </Annotation>
    </Annotations>
    ```

## Step 4. Configuring the Visual Filters of type Donut Chart

In this step, let us try to configure a visual filter with a different Dimension using a Donut Chart

1. Expand the guide **Add a new visual filter** in the Analytical List Page group.

    ![](images/unit2/img_026.png)


2. Click **Start Guide**.

    ![](images/unit2/img_027.png)


3. **Visual Filter Guide(Step 1) - To configure a UI.Chart annotation**: 
   
    In the Entity Type field, choose your entity type as : **BookingType**. 

    ![](images/unit2/img_039.png)

    Enter the following values in the respective fields and Click **Insert Snippet**

    | **Field**             |**Value**
    | --------------------- |----------------------------------
    | Chart Qualifier       |FilterFlightPriceCustomerID
    | Chart Title           |Filter FlightPrice by CustomerID
    | Chart Description     |Filter FlightPrice by CustomerID
    | ChartType             |Donut
    | Dimensions Property   |CustomerID
    | Measures property     |FlightPrice

    ![](images/unit2/img_040.png)

    The UI.Chart annotation is now added to the annotation file. Click **Step 2** .

    ![](images/unit2/img_041.png)


4. **Visual Filter Guide(Step 2) - To configure a UI.PresentationVariant annotation** : 

    Enter the following values and click **Insert Snippet**.

    |**Field**                        |**Value**
    |-------------------------------- |----------------------------------
    |Presentation Variant Qualifier   |PVFilterFlightPriceCustomerID
    |Chart Reference                  |\@UI.Chart\#FilterFlightPriceCustomerID

    ![](images/unit2/img_042.png)

    The UI.PresentationVariant annotation is now added to the annotation file, click
    **Step 3**

    ![](images/unit2/img_043.png)


5. **Visual Filter Guide(Step 3) - To configure a ValueList annotation** : 

    Enter the following values in the respective fields and click **Insert Snippet**.

    |**Field**                        |**Value**
    |-------------------------------- |------------------------------------
    |Entity Type                      |BookingType
    |Entity Type Property             |CustomerID
    |Collection Path                  |Booking
    |Presentation Variant Qualifier   |PVFilterFlightPriceCustomerID
    |Local Data Property              |CustomerID
    |Value List Property              |CustomerID

    ![](images/unit2/img_044.png)

    The Common.ValueList Annotation is now added to the annotation file. <br>
    Click **Exit Guide** to get back to the Guides. <br/>

    ![](images/unit2/img_045.png) 

     Now we can see the UI.Chart and UI.PresentationVariant and common.valuelist annotation is added to your local annotation file as configured in the code snippet below.

    ```
    <Annotation Term="UI.Chart" Qualifier="FilterFlightPriceCustomerID">
        <Record Type="UI.ChartDefinitionType">
            <PropertyValue Property="Title" String="Filter FlightPrice By CustomerID"/>
            <PropertyValue Property="Description" String="Filter FlightPrice By CustomerID"/>
            <PropertyValue Property="ChartType" EnumMember="UI.ChartType/Donut"/>
            <PropertyValue Property="Dimensions">
                <Collection>
                    <PropertyPath>CustomerID</PropertyPath>
                </Collection>
            </PropertyValue>
            <PropertyValue Property="Measures">
                <Collection>
                    <PropertyPath>FlightPrice</PropertyPath>
                </Collection>
            </PropertyValue>
        </Record>
    </Annotation>
    <Annotation Term="UI.PresentationVariant" Qualifier="PVFilterFlightPriceCustomerID">
        <Record Type="UI.PresentationVariantType">
            <PropertyValue Property="Visualizations">
                <Collection>
                    <AnnotationPath>@UI.Chart#FilterFlightPriceCustomerID</AnnotationPath>
                </Collection>
            </PropertyValue>
        </Record>
    </Annotation>
   ```
   ```
     <Annotations Target="cds_zfe_booking_analytics_######.BookingType/CustomerID">
        <Annotation Term="Common.ValueList">
            <Record Type="Common.ValueListType">
                <PropertyValue Property="CollectionPath" String="Booking"/>
                <PropertyValue Property="PresentationVariantQualifier" String="PVFilterFlightPriceCustomerID"/>
                <PropertyValue Property="Parameters">
                    <Collection>
                        <Record Type="Common.ValueListParameterInOut">
                            <PropertyValue Property="LocalDataProperty" PropertyPath="CustomerID"/>
                            <PropertyValue Property="ValueListProperty" String="CustomerID"/>
                        </Record>
                    </Collection>
                </PropertyValue>
            </Record>
        </Annotation>
    </Annotations>
    ```
## Step 5. Configuring the Visual Filters of type Bar Chart

In this step, Let us try to configure a visual filter with a different dimension using a bar chart

1. Expand the guide **Add a new visual filter** in the Analytical List Page group.

    ![](images/unit2/img_026.png)


2. Click **Start Guide**.

    ![](images/unit2/img_027.png)


3. **Visual Filter Guide(Step 1) - To configure a UI.Chart annotation** : 
   
    In the field **Entity Type**, choose your entity type as : **BookingType**. 

    ![](images/unit2/img_046.png)

    Enter the following values in the respective fields and click **Insert Snippet**

    | **Field**             |**Value**
    | --------------------- |----------------------------------
    | Chart Qualifier       |FilterFlightPriceAgencyID
    | Chart Title           |Filter FlightPrice by AgencyID
    | Chart Description     |Filter FlightPrice by AgencyID
    | ChartType             |Bar
    | Dimensions Property   |AgencyID
    | Measures property     |FlightPrice

    ![](images/unit2/img_047.png)

    The UI.Chart annotation is now added to the annotation file. Click **Step 2** .

    ![](images/unit2/img_048.png)


4. **Visual Filter Guide(Step 2) - To configure a UI.PresentationVariant annotation**
    
    Enter the following values and click **Insert Snippet**.

    |**Field**                        |**Value**
    |-------------------------------- |----------------------------------
    |Presentation Variant Qualifier   |PVFilterFlightPriceAgencyID
    |Chart Reference                  |\@UI.Chart\#FilterFlightPriceAgencyID

    ![](images/unit2/img_049.png)

    The UI.PresentationVariant annotation is now added to the annotation file, click **Step 3**

    ![](images/unit2/img_050.png)


5. **Visual Filter Guide(Step 3) - To configure a ValueList annotation** : 

    Enter the following values in the respective fields and click **Insert Snippet**.

    |**Field**                        |**Value**
    |-------------------------------- |------------------------------------
    |Entity Type                      |BookingType
    |Entity Type Property             |AgencyID
    |Collection Path                  |Booking
    |Presentation Variant Qualifier   |PVFilterFlightPriceAgencyID
    |Local Data Property              |AgencyID
    |Value List Property              |AgencyID

    ![](images/unit2/img_051.png)

    The Common.ValueList annotation is now added to the annotation file. <br>

    Click **Exit Guide** to get back to the Guides.

    ![](images/unit2/img_052.png) 

     Now we can see the UI.Chart and UI.PresentationVariant and common.valuelist annotation is added to your local annotation file as configured in the code snippet below.

    ```
    <Annotation Term="UI.Chart" Qualifier="FilterFlightPriceAgencyID">
            <Record Type="UI.ChartDefinitionType">
                <PropertyValue Property="Title" String="Filter FlightPrice By AgencyID"/>
                <PropertyValue Property="Description" String="Filter FlightPrice By AgencyID"/>
                <PropertyValue Property="ChartType" EnumMember="UI.ChartType/Bar"/>
                <PropertyValue Property="Dimensions">
                    <Collection>
                        <PropertyPath>AgencyID</PropertyPath>
                    </Collection>
                </PropertyValue>
                <PropertyValue Property="Measures">
                    <Collection>
                        <PropertyPath>FlightPrice</PropertyPath>
                    </Collection>
                </PropertyValue>
            </Record>
        </Annotation>
        <Annotation Term="UI.PresentationVariant" Qualifier="PVFilterFlightPriceAgencyID">
            <Record Type="UI.PresentationVariantType">
                <PropertyValue Property="Visualizations">
                    <Collection>
                        <AnnotationPath>@UI.Chart#FilterFlightPriceAgencyID</AnnotationPath>
                    </Collection>
                </PropertyValue>
            </Record>
        </Annotation>
    ```
   ```
    <Annotations Target="cds_zfe_booking_analytics_######.BookingType/AgencyID">
        <Annotation Term="Common.ValueList">
            <Record Type="Common.ValueListType">
                <PropertyValue Property="CollectionPath" String="Booking"/>
                <PropertyValue Property="PresentationVariantQualifier" String="PVFilterFlightPriceAgencyID"/>
                <PropertyValue Property="Parameters">
                    <Collection>
                        <Record Type="Common.ValueListParameterInOut">
                            <PropertyValue Property="LocalDataProperty" PropertyPath="AgencyID"/>
                            <PropertyValue Property="ValueListProperty" String="AgencyID"/>
                        </Record>
                    </Collection>
                </PropertyValue>
            </Record>
        </Annotation>
    </Annotations>
    ```

## Step 6. Preview the application to view the visual filters 

1. Right click **webapp folder**.

    ![](images/unit2/img_019.png)


2. Click on **Preview Application**.

    ![](images/unit2/img_020.png)


3. Click on **start fiori run --open 'test/flpSandbox.html#bookinganalysis-tile'**.

    ![](images/unit2/img_021.png)


4. To view the application in a new browser tab click **Open** in the dialog.

    ![](images/unit2/img_022.png)


5. To view the chart and table click : **Go**.

    ![](images/unit2/img_059.png)

    ![](images/unit2/img_060.png)


## Step 7. Add a default value to a filter field 
In this step, let us try to add a default value to a filter field. This value would be applied automatically to a field when the app is loaded. 

This can be achieved using the annotation : Common.FilterDefaultValue

Lets add a default value **2021** to the field **Booking Date Year**. The annotation is added to the value list annotation section.

1. In the property annotation section of the BookingDateYear, add the following annotation
    ```
    <Annotation Term="Common.FilterDefaultValue" String="2021"/>
    ```
    ![](images/unit2/img_053.png)
    
    ![](images/unit2/img_054.png)

## Step 8. Preview the application to view the default value added

1. Right click **webapp folder**.

    ![](images/unit2/img_019.png)


2. Click on **Preview Application**.

    ![](images/unit2/img_020.png)


3. Click on **start fiori run --open 'test/flpSandbox.html#bookinganalysis-tile'**.

    ![](images/unit2/img_021.png)


4. To view the application in a new browser tab click **Open** in the dialog. <br>

    You could now see a default filter is applied to the **BookingDateYear** field.

    ![](images/unit2/img_057.png)


5. To view the compact filters click  ![](images/unit2/fieldicon_20.png) (filter toogle for compact filters).

    ![](images/unit2/img_058.png)


## Summary
You have completed the exercise!

In this unit, you have learned how to 
- enhance the SAP Fiori application based on the Analytical List Page floor plan with filtering capabilities. 
- configure the compact and visual filter
- to add a default value to a filter field by configuration.


## Next Exercise

In the next exercise, we will show how to generate and to configure the overview page application.<br/>
[Week 3 Unit 3: Creating an overview page](unit3.md)






