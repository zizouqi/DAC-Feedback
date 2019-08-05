## [0805]修复：两个二星德鲁伊自动合成三星

问题：  
在改用 `CombineChessPlus()` 后，当场上有四德鲁伊时，合成第二个二星德鲁伊不会自动升级为三星。  

分析：  
在 `CombineChessPlus()` 中，是使用 `Find2SameChessInHandOrOnBoard()` 来寻找可以进一步合成升星的棋子。  
 `Find2SameChessInHandOrOnBoard()` 同时被使用在了 `function DAC:OnRequestBuyChess()` 之中。而为了避免购买德鲁伊时三个自动合成，`Find2SameChessInHandOrOnBoard()` 遍历棋子的条件语句中排除了所有德鲁伊职业的棋子。  

修改：  
将 `Find2SameChessInHandOrOnBoard()` 条件语句中的逻辑从**“不能是德鲁伊”**修改为**“要么不是德鲁伊，要么是二星德鲁伊”**。  
另外 `CombineChessPlus()` 中，给棋子赋值的顺序是先 u2 再 u1（`local have_exist_count,u2,u1 = Find2SameChessInHandOrOnBoard(hero,advance_unit_name)`），而在合成德鲁伊时只有 u2 没有 u1，所以后面针对德鲁伊的合成操作需要将 u1 改为 u2。