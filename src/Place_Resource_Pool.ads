with Generic_Resource_Pool;
with Site;

-- Un pool de places utilisant le pool générique
package Place_Resource_Pool is new Generic_Resource_Pool(Resource_Id => Site.Place_Names);
