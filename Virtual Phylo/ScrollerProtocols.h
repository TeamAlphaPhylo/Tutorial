
// PROTOCOL
@protocol CCItemsScrollerDelegate <NSObject>

@required

- (void)itemsScroller:(CCItemsScroller *)sender didSelectItemIndex:(int)index;

@optional

- (void)itemsScrollerScrollingStarted:(CCItemsScroller *)sender;

@end


// PROTOCOL
@protocol CCSelectableItemDelegate <NSObject>

@optional

-(void)setIsSelected:(BOOL)isSelected;

@end