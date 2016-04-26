
//
//  MFDB.h
//  MFSC
//
//  Created by mfwl on 16/4/19.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#ifndef MFDB_h
#define MFDB_h



#define kDocDir [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define searchListName @"searchHistorytab.db"
#define dbPath [kDocDir stringByAppendingPathComponent:searchListName]
#define carPath [kDocDir stringByAppendingPathComponent:@"shoppingCart.db"]


#endif /* MFDB_h */
