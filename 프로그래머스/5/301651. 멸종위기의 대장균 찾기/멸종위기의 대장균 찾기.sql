WITH RECURSIVE ECOLI_TREE AS (
    SELECT ID, PARENT_ID, 1 AS GENERATION
    FROM ECOLI_DATA
    WHERE PARENT_ID IS NULL

    UNION ALL

    SELECT ECOLI_DATA.ID, ECOLI_DATA.PARENT_ID, ECOLI_TREE.GENERATION + 1
    FROM ECOLI_DATA 
    JOIN ECOLI_TREE  
    ON ECOLI_DATA.PARENT_ID = ECOLI_TREE.ID
), 

NO_CHILDREN AS (
    SELECT ECOLI_TREE.ID, ECOLI_TREE.GENERATION
    FROM ECOLI_TREE
    LEFT JOIN ECOLI_DATA
    ON ECOLI_TREE.ID = ECOLI_DATA.PARENT_ID
    WHERE ECOLI_DATA.ID IS NULL
)

SELECT COUNT(ID) AS COUNT, GENERATION
FROM NO_CHILDREN
GROUP BY GENERATION
ORDER BY GENERATION;