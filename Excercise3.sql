-- Requerimientos del ejercicio:
-- 1. Encontrar los 5 clientes con mayor gasto total en ventas.
-- 2. Determinar en qué tienda compraron más veces (en términos de cantidad de transacciones).
-- 3. Mostrar el siguiente resultado:
    -- Nombre del cliente
    -- Total gastado
    -- Nombre de la tienda más visitada
    -- Número de compras en esa tienda

select 
    top 5
    CONCAT(cu.FirstName, ' ',cu.LastName) as complete, 
    sum(fa.SalesAmount) as total_Sales, 
    st.StoreName,
    count(*)
from DimCustomer cu
join FactSales fa on cu.CustomerKey = fa.SalesKey
join DimStore st on fa.StoreKey = st.StoreKey
where cu.FirstName is not NULL 
    and cu.LastName is not NULL
    and st.StoreName is not NULL
group by CONCAT(cu.FirstName, ' ',cu.LastName), st.StoreName
order by SUM(fa.SalesAmount) DESC;
