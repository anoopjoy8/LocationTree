<cfset local.inputId = 5/>
<cfset local.parent_lists = "">
<cfquery name="get_locations">
    select id, parent_id, location_name 
    from location_tree
</cfquery>

<cfquery name="get_parent_locations" dbtype="query">
    select parent_id as parentId , location_name as locationName
    from get_locations
    where id = <cfqueryparam value="#local.inputId#" cfsqltype="cf_sql_integer" />
</cfquery>

    <cfloop query="get_parent_locations">
        <cfset local.Fresult = processTreeNode(parentId=get_parent_locations.parentId) />
    </cfloop>

<cffunction name="processTreeNode" output="true">
    <cfargument name="parentId" type="numeric" />

    <cfquery name="LOCAL.qFindParent" dbtype="query">
        select parent_id as locationId , location_name 
        as locationName
        from get_locations
        where id = <cfqueryparam value="#arguments.parentId#" cfsqltype="cf_sql_integer" />
    </cfquery>
        <cfif arguments.parentId NEQ  0>
             <cfset FinalResult(arguments.parentId) />
        </cfif>
            <cfif LOCAL.qFindParent.recordcount>
                    <cfloop query="LOCAL.qFindParent">
                        <cfset processTreeNode(parentId=LOCAL.qFindParent.locationId) />
                    </cfloop>
            </cfif>

</cffunction>

<cffunction name="FinalResult" output="true">
   <cfargument name="parentidList" type="string" /> 
   <cfset local.parent_lists = ListAppend('#arguments.parentidList#','')>
        #local.parent_lists#
</cffunction>