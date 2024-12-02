## Goal
How many trees are visible from the outside the grid.

## Analysis
I can see all surrounding trees.
- I see all trees in the first and last column.
- I can see all first and last row.

Consider zero based index. And nomenclature 1,1:5 meaning row,column:element.

3037
2551
6533
3354

On 1,1:5 seen from LEFT, TOP. Not RIGHT, BOTTOM. Both heights same as current tree.

On 1,2:5 seen from TOP, RIGHT. Not LEFT, boom. LEFT same  height, BOTTOM higher height.



t,t,t,t
t,t,t,t
t,t,t,t
t,t,t,t

Row 1:
- All can be seen

Row 2:
- LEFT
  - 2 can be seen.
    - Tallest 2.
  - 5 taller than tallest 2, can be seen LEFT.
    - Tallest 5.
  - 5 equal to tallest (and it's not current) 5, can't be seen LEFT.
    - Tallest 5.
    - t,t,t,t
      t,t,F,t
      t,t,t,t
      t,t,t,t
- RIGHT
  - 1 can be seen.
    - Tallest 1.
  - 5 can't be seen LEFT ignore.
    - Tallest 5
  - 5 equal to tallest 5 (and it's not current), can't be seen RIGHT.
    - Tallest 5
    - t,t,t,t
      t,F,F,t
      t,t,t,t
      t,t,t,t

Row 3:
- LEFT:
  - 6 can be seen.
    - Tallest 6.
  - 5 smaller than tallest 6, can't be seen LEFT.
    - Tallest 6.
    - t,t,t,t
      t,F,F,t
      t,F,t,t
      t,t,t,t
  - 3 smaller than tallest 6, can't be seen LEFT.
    - Tallest 6.
    - t,t,t,t
      t,F,F,t
      t,F,F,t
      t,t,t,t
- RIGHT:
  - No needed all center trees are not visible.

