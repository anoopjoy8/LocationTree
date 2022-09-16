<cfquery name="get_locations">
    select id, parent_id, location_name 
    from location_tree
</cfquery>

<cfset processTreeNode(location_Id=5) />

<cffunction name="processTreeNode" output="true">
    <cfargument name="location_Id" type="numeric" />
    <cfquery name="local.qFindChildren" dbtype="query">
        select id as locationId , location_name 
        as locationName,parent_id as parentId
        from get_locations
        where id = <cfqueryparam value="#arguments.location_Id#" cfsqltype="cf_sql_integer" />
    </cfquery>
    <cfset processNextlevel(parent_Id=local.qFindChildren.parentId,count="0") />
</cffunction>

<cffunction name="processNextlevel" output="true">
    <cfargument name="parent_Id" type="numeric" />
    <cfset local.count = arguments.count>
    <cfquery name="local.qFindParent" dbtype="query">
        select id as locationId , location_name 
        as locationName,parent_id as parentId
        from get_locations
        where id = <cfqueryparam value="#arguments.parent_Id#" cfsqltype="cf_sql_integer" />
    </cfquery>
    <cfloop query="local.qFindParent">
     <cfset local.count = local.count+1>
            <cfif local.qFindParent.parentId neq "0">
                <cfset processNextlevel(parent_Id=local.qFindParent.parentId,count=count) />
            </cfif>
            <cfif local.qFindParent.parentId eq "0">
                <cfset local.deapth = local.count+1>
                <cfset FinalResult(local.deapth) />
            </cfif>
    </cfloop>
   
</cffunction>

<cffunction name="FinalResult" output="true">
   <cfargument name="deapthValue" type="numeric" /> 
        #deapthValue#
</cffunction>