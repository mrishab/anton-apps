## Override the member-limit of 3 for free-plan:

```sh
docker exec -ti affine_postgres psql -U affine

```

```sql
UPDATE features 
SET configs = jsonb_set(configs::jsonb, '{memberLimit}', '10')
WHERE configs::jsonb ? 'memberLimit';
```