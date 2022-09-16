<cfset local.inputId = 1/>
<cfset local.childLists = "">
<cfquery name="get_locations">
    select id, parent_id, location_name 
    from location_tree
</cfquery>

<cfquery name="get_parent_locations" dbtype="query">
    select id as location_Id , location_name as locationName
    from get_locations
    where id = <cfqueryparam value="#local.inputId#" cfsqltype="cf_sql_integer" />
</cfquery>

<cfset processTreeNode(location_Id=get_parent_locations.location_Id,inputId = local.inputId) />

<cffunction name="processTreeNode" output="true">
    <cfargument name="location_Id" type="numeric" />
    <cfquery name="LOCAL.qFindChildren" dbtype="query">
        select id as locationId , location_name 
        as locationName
        from get_locations
        where parent_id = <cfqueryparam value="#arguments.location_Id#" cfsqltype="cf_sql_integer" />
    </cfquery>
        <cfif LOCAL.qFindChildren.recordcount>
                    <cfloop query="LOCAL.qFindChildren">
                        <!--- Recursively call function --->
                        <cfset processTreeNode(location_Id=LOCAL.qFindChildren.locationId,inputId = arguments.inputId) />
                    </cfloop>
        </cfif>
        <cfif arguments.location_Id NEQ  arguments.inputId>
            <cfset local.childLists = ListAppend('#arguments.location_Id#','')> 
            <cfset FinalResult(childList=local.childLists) />
        </cfif>
</cffunction>

<cffunction name="FinalResult" output="true">
   <cfargument name="childList" type="string" />
        #arguments.childList#
</cffunction>

