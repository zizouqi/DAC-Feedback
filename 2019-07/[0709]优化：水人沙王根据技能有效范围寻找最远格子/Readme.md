## 优化：水人沙王根据技能有效范围寻找最远格子

目前水人施法是选择目标位置的逻辑是最远且能攻击到敌人的格子。但因为水人是远程单位，故在一些情况下会有技能路径上没有敌方单位导致空放技能的情况。

优化的代码则是根据位移技能的有效伤害范围（npc_abilities_custom.txt 内对技能定义的 width 值）来选取最远的目标格子。

<img src="https://github.com/zizouqi/DAC-Feedback/blob/master/Misc/Image/201907/morph.gif" alt="after" title="after" />