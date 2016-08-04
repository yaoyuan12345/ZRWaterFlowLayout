# ZRWaterFlowLayout
这是一个使用UICollectionView 完成的瀑布流，通过重写UICollectionViewLayout这个类来实现的！

#使用步骤
1、导入 ZRWaterFlowLayout.h  和  ZRWaterFlowLayout.m

2、
   ** ZRWaterFlowLayout *flowlayout = [[ZRWaterFlowLayout alloc] init];
    flowlayout.delegate = self;**注意把Layout 替换成ZRWaterFlowLayout

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowlayout];
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:collectionView];
    
    
    
 3、设置ZRWaterFlowLayout的委托  
 
 @required（必须实现的）
 
//返回item的高度   根据（图片的宽度、图片的高度、item的宽度）返回item的高度
- (NSInteger)zrWaterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout heightRowOfIndex:(NSInteger)index withItemWidth:(CGFloat )width;



@optional （这个是可选的）

// ---- 瀑布流的列数
- (CGFloat)columnCountInWaterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout;

// ---- 瀑布流的列间距
- (CGFloat)columnMarginInWaterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout;

// ---- 瀑布流的行间距
- (CGFloat)rowMarginInWaterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout;

// ---- 整个瀑布流的内边距
- (UIEdgeInsets)edgeInsetInWaterFlowLayout:(ZRWaterFlowLayout *)waterFlowLayout; 
