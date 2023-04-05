CREATE FUNCTION rc_datumnar (
    @rc nvarchar(30)
)
RETURNS DATE AS
BEGIN
    DECLARE @datumnar as date
    DECLARE @datumnarchar as nvarchar(255)
    DECLARE @rok as nvarchar(5)
    DECLARE @mpom as INT
    DECLARE @mesic as nvarchar(3)
    DECLARE @den as nvarchar(3)

    SELECT 
        @rok = case when cast(SUBSTRING(@rc,1,2)as int) > 30 then '19'+SUBSTRING(@rc,1,2) else '20'+SUBSTRING(@rc,1,2) end,
        @mpom = case when substring(@rc,3,2) > 40 then cast(substring(@rc,3,2) as int) - 50 else cast(substring(@rc,3,2) as INT) end,
        --FUNCKCNI jen u lidi narozene od roku 1940
        @mesic = case when len(@mpom) = 1 then '0'+ cast(@mpom as nvarchar(2)) else cast(@mpom as nvarchar(2)) end,
        @den = substring(@rc,5,2),
        @datumnarchar = @rok+'-'+@mesic+'-'+@den
         
    SET @datumnar = CAST(@datumnarchar AS DATE)
        
    RETURN @datumnar
END
;

select dbo.rc_datumnar('2262060123')



