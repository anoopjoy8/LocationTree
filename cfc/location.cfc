<cfquery name="get_locations">
    select id, parent_id, location_name
    from location_tree
</cfquery>

<cfquery name="get_parent_locations" dbtype="query">
    select id as LocId , location_name 
    as LocName
    from get_locations
    where parent_id is null
</cfquery>

<ul class="tree">
    <cfloop query="get_parent_locations">
        <cfset processTreeNode(LocId=get_parent_locations.LocId, folderName=get_parent_locations.LocName) />
    </cfloop>
</ul>

<cffunction name="processTreeNode" output="true">
    <cfargument name="LocId" type="numeric" />
    <cfargument name="folderName" type="string" />
    <!--- Check for any nodes that have *this* node as a parent --->
    <cfquery name="LOCAL.qFindChildren" dbtype="query">
        select id as folder_id , location_name 
        as LocName
        from get_locations
        where parent_id = <cfqueryparam value="#arguments.LocId#" cfsqltype="cf_sql_integer" />
    </cfquery>
    <li>#arguments.folderName# <br>
        <cfif LOCAL.qFindChildren.recordcount >
            <!--- We have another list! --->
            <ul>
                <!--- We have children, so process these first --->
                <cfloop query="LOCAL.qFindChildren">
                    <!--- Recursively call function --->
                    <cfset processTreeNode(LocId=LOCAL.qFindChildren.folder_id,folderName=LOCAL.qFindChildren.LocName) />
                </cfloop>
            </ul>
        </cfif>
    </li>
</cffunction>