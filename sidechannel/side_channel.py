import numpy as np

S_box = [1,2,3,0]
#S盒
Hw_box = [0,1,1,2]
#汉明重量
input = np.array([0,1,2,3])
power = np.array([2,0,1,1])

def side_channel_attack():
    corr = []
    Sin = np.array([[0 for i in range(4)] for j in range(4)])
    output = np.array([[0 for i in range(4)] for j in range(4)])
    HW = np.array([[0 for i in range(4)] for j in range(4)])
    #初始化矩阵
    print(Sin.shape)
    for key in range(4):
        Sin[key] = input^key
        #遍历Key，计算中间状态Sin
        #print(Sin)
        for i in range(4):
            output[key][i] = S_box[Sin[key][i]]
            HW[key][i] = Hw_box[output[key][i]]
        #计算output和汉明重量向量
    for Key in range(4):
        print("Key = ",Key)
        print("相关系数矩阵为：")
        print(np.corrcoef(HW[Key],power)) 
        #计算相关系数矩阵，取相关系数
        corr.append(np.corrcoef(HW[Key],power)[0][1])
    corr = np.array(corr)
    Key = np.argmax(corr)
    #找到相关系数最大的Key，并输出中间状态
    print("相关性最大的Key:",Key)
    print("Sin中间状态的值为:",Sin[Key])
    print("output的值为:",output[Key])
    return 


side_channel_attack()
