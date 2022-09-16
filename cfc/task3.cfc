<cfquery name="get_locations">
    select id, parent_id, location_name
    from location_tree
    Order BY location_name
</cfquery>

<cfquery name="get_parent_locations" dbtype="query">
    select id as location_Id , location_name as location_Name
    from get_locations
    where parent_id = 0
</cfquery>

<ul class="tree">
    <cfloop query="get_parent_locations">
        <cfset processTreeNode(location_Id=get_parent_locations.location_Id, location_Name=get_parent_locations.location_Name) />
    </cfloop>
</ul>

<cffunction name="processTreeNode" output="true">
    <cfargument name="location_Id" type="numeric" />
    <cfargument name="location_Name" type="string" />

    <cfquery name="LOCAL.qFindChildren" dbtype="query">
        select id as locationId , location_name 
        as location_Name
        from get_locations
        where parent_id = <cfqueryparam value="#arguments.location_Id#" cfsqltype="cf_sql_integer" />
    </cfquery>
    <li>#arguments.location_Name# 
        <cfif LOCAL.qFindChildren.recordcount >
            <ul>
                <cfloop query="LOCAL.qFindChildren">
                    <!--- Recursively call function --->
                    <cfset processTreeNode(location_Id=LOCAL.qFindChildren.locationId,location_Name=LOCAL.qFindChildren.location_Name) />
                </cfloop>
            </ul>
        </cfif>
    </li>
</cffunction>