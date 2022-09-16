<cfquery name="get_locations">
    select id, parent_id, location_name
    from location_tree
</cfquery>

<cfquery name="get_parent_locations" dbtype="query">
    select id as location_Id , location_name as locationName
    from get_locations
    where parent_id = 0
</cfquery>

<ul class="tree">
    <cfloop query="get_parent_locations">
        <cfset processTreeNode(location_Id=get_parent_locations.location_Id, location_Name=get_parent_locations.locationName) />
    </cfloop>
</ul>

<cffunction name="processTreeNode" output="true">
    <cfargument name="location_Id" type="numeric" />
    <cfargument name="location_Name" type="string" />
    <!--- Check for any nodes that have *this* node as a parent --->
    <cfquery name="LOCAL.qFindChildren" dbtype="query">
        select id as locationId , location_name 
        as locationName
        from get_locations
        where parent_id = <cfqueryparam value="#arguments.location_Id#" cfsqltype="cf_sql_integer" />
    </cfquery>
    <li>#arguments.location_Name# <br>
        <cfif LOCAL.qFindChildren.recordcount >
            <!--- We have another list! --->
            <ul>
                <!--- We have children, so process these first --->
                <cfloop query="LOCAL.qFindChildren">
                    <!--- Recursively call function --->
                    <cfset processTreeNode(location_Id=LOCAL.qFindChildren.locationId,location_Name=LOCAL.qFindChildren.locationName) />
                </cfloop>
            </ul>
        </cfif>
    </li>
</cffunction>