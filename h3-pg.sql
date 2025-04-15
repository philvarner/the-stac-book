-- Using the h3-pg extension (https://github.com/uber/h3-pg)
CREATE EXTENSION h3;

-- Converting geometry to H3 indexes at resolution 7
SELECT 
    h3_geo_to_h3(ST_Transform(geometry, 4326)::geography, 7) AS h3_index,
    COUNT(*) AS item_count,
    array_agg(item_id) AS item_ids
FROM my_stac_items
GROUP BY h3_index;

-- Visualizing the H3 hexagons
SELECT 
    h3_index,
    item_count,
    h3_cell_to_boundary_geometry(h3_index) AS hex_geometry
FROM (
    SELECT 
        h3_geo_to_h3(ST_Transform(geometry, 4326)::geography, 7) AS h3_index,
        COUNT(*) AS item_count
    FROM my_stac_items
    GROUP BY h3_index
) AS hex_counts;