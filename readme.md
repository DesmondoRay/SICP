## 《计算机程序的构造与解释》第二版
 Structure and Interpretation of Computer Program (Second Edition)

### 编程环境
- 操作系统：	Ubuntu 16.04  
- 解释器：	mit-scheme，DrRacket（练习 3.47需要使用）  

若是选择mit-scheme，建议与notepad搭配使用（或类似的文本编辑器），  
设置notepad的 Run >> Modify Run Commands，在command栏里填写：  
```gnome-terminal --working-directory=%directory% -x mit-scheme --load "%path%"```  
运行command，可直接在终端内打开mit-scheme，并加载该文件。而不必每次输入：```(load "XXX.scm")```。

### 练习题
尽量对完成的所有习题进行测试，并附上测试结果；  
画图题没有上传，个别难度系数较高的编程题未完成。  

### 参考网站
- [MIT/GNU Scheme 9.2 Documentation](https://www.gnu.org/software/mit-scheme/documentation/mit-scheme-ref/)   
- [Complete Code from SICP Second Edition](http://mitpress.mit.edu/sites/default/files/sicp/code/index.html)  
- [MIT OPEN COURSE Video Lectures](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-001-structure-and-interpretation-of-computer-programs-spring-2005/video-lectures/)  
- [《计算机程序的构造和解释》视频公开课中文化项目](https://github.com/DeathKing/Learning-SICP)  
- [SICP 解题集](http://sicp.readthedocs.io/en/latest/index.html)  