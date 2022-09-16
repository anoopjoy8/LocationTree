<cfquery name="get_locations">
    select id, parent_id, location_name 
    from location_tree
</cfquery>

<cfset local.depth = processNextlevel(parent_Id=3,count=0) />

<cffunction name="processNextlevel" output="true">
    <cfargument name="parent_Id" type="numeric" />
    <cfset local.count = arguments.count>
    <cfquery name="local.qFindParent" dbtype="query">
        select id as locationId , location_name 
        as locationName,parent_id as parentId
        from get_locations
        where id = <cfqueryparam value="#arguments.parent_Id#" cfsqltype="cf_sql_integer" />
    </cfquery>
    <cfset local.count = local.count+1>
    <cfif local.qFindParent.parentId neq "0">
        <cfset processNextlevel(parent_Id=local.qFindParent.parentId,count=count) />
    </cfif>
    <cfif local.qFindParent.parentId eq "0">
        <cfset local.depth = local.count+1>
        <cfreturn local.depth>
    </cfif>
</cffunction>
