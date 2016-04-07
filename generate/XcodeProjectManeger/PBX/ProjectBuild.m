//
//  ProjectBuild.m
//  FFXcodeProjectManager
//
//  Created by Rich on 16/3/16.
//  Copyright © 2016年 Florian Friedrich. All rights reserved.
//

#import "ProjectBuild.h"
#import "FFXCProjectUIDGenerator.h"
//#import "PBXGroup.h"
//#import "PBXBuildFile.h"
#import "ProjectBuilder.h"


@interface ProjectBuild()

@property (nonatomic,strong) NSDictionary *objectsDict;
@property (nonatomic,strong) NSDictionary *allDataDict;
@property (nonatomic,strong) NSMutableArray *groupArr;
@property (nonatomic,strong) NSMutableArray *buildFilesArr;
@property (nonatomic,strong) NSURL *url;


@end

@implementation ProjectBuild

- (void)initEntity
{
    _groupArr = [NSMutableArray array];
    _buildFilesArr = [NSMutableArray array];
    _objectsDict = [NSDictionary dictionary];
    _allDataDict = [NSDictionary dictionary];
    _originDataModel = [OriginDataModel shareInstance];
    
}

//+一个有文件的group
- (void)customPbxprojInsertGroupAndClass:(NSURL*)url outputPath:(NSString*)outputPath
{
    [self initEntity];
    
    _url = _originDataModel.xcodeproUrl;
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",_originDataModel.outputPath,_busiName]; // 要列出来的目录
    
    NSFileManager *myFileManager=[NSFileManager defaultManager];
    
    NSDirectoryEnumerator *myDirectoryEnumerator;
    
    myDirectoryEnumerator=[myFileManager enumeratorAtPath:path];
    
    //列举目录内容，可以遍历子目录
    
    NSLog(@"用enumeratorAtPath:显示目录%@的内容：",path);
    
    NSArray *filesArr = [NSArray array];
    NSMutableDictionary *filesDict = [NSMutableDictionary dictionary];
    NSMutableArray *lastComponetArr;
    NSString *keyPath;
    //把文件和路径提取出来
    while((path=[myDirectoryEnumerator nextObject])!=nil)
    {
        NSLog(@"%@",path);
        if ([path containsString:@"."] && ![path containsString:@".DS_Store"] && [path containsString:[NSString stringWithFormat:@"%@/",_originDataModel.moduleName]])
        {//如果没有. 则是文件夹 是group
            
            NSString *tempKeyPath = [path stringByDeletingLastPathComponent];
            if ([keyPath isEqualToString:tempKeyPath])
            {
                [lastComponetArr addObject:[path lastPathComponent]];
                
            }
            else
            {
                keyPath = [path stringByDeletingLastPathComponent];
                lastComponetArr = [NSMutableArray array];
                [lastComponetArr addObject:[path lastPathComponent]];
            }
            
            [filesDict setValue:lastComponetArr forKey:keyPath];
        }
    }
    
    NSLog(@"%@",filesDict);
    _groupArr = [NSMutableArray array];
    filesArr = [filesDict allKeys];
    for (int i = 0; i < filesArr.count; i ++) {
        NSString *path = filesArr[i];
        NSArray *arr = [path componentsSeparatedByString:@"/"];
        //init keys
        NSMutableArray *groupKeys = [NSMutableArray array];
        for (int j = 0; j < arr.count; j ++)
        {
            [groupKeys addObject:@[[FFXCProjectUIDGenerator randomXcodeProjectUIDWithLength:24]]];
        }
        NSArray *filesArr = [filesDict valueForKey:path];//.h/.m必须区分开来
        NSMutableArray *filesKeyArr_h = [NSMutableArray array];
        NSMutableArray *filesKeyArr_m = [NSMutableArray array];
        NSMutableArray *filesKeyArr = [NSMutableArray array];
        for (NSString *fileName in filesArr)
        {
            NSString *fileRef = [FFXCProjectUIDGenerator randomXcodeProjectUIDWithLength:24];
            if ([fileName containsString:@".h"])
            {
                [filesKeyArr_h addObject:fileRef];
                
            }
            else if ([fileName containsString:@".m"])
            {
                [filesKeyArr_m addObject:fileRef];
                
            }
            PBXBuildFile *buildFile = [PBXBuildFile buildFileWith:fileName fileRef:fileRef];
            [_buildFilesArr addObject:buildFile];
        }
        
        [filesKeyArr addObjectsFromArray:filesKeyArr_h];
        [filesKeyArr addObjectsFromArray:filesKeyArr_m];
        [groupKeys addObject:filesKeyArr];
        
        //edit pbxprojc
        for (int j = 0; j < arr.count; j ++) {
            NSString *groupName = arr[j];
            PBXGroup *group = [PBXGroup groupWithName:groupName childName:nil type:j childrenKeys:groupKeys];
            [_groupArr addObject:group];
            
        }
    }
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:_url];
    _allDataDict = dictionary;
    NSMutableDictionary *objcsDict = dictionary[@"objects"];
    _objectsDict = objcsDict;
    [self insertDataToPBXProjDict];
    
}

- (void)insertDataToPBXProjDict
{
    /* Begin PBXGroup section */
    NSMutableArray *groupKeys = [NSMutableArray array];
    for (int i = 0; i < _groupArr.count; i ++)
    {
        PBXGroup *group = _groupArr[i];
        NSDictionary *insertGroupDict;

        insertGroupDict = @{
                            @"isa" : group.isa,
                            @"children" : group.children,
                            @"name" : group.name,
                            @"sourceTree" : group.sourceTree,
                            @"path" : group.path,
                            };
        [_objectsDict setValue:insertGroupDict forKey:group.key];
        if ([group.path containsString:_originDataModel.moduleName] || [group.name containsString:_originDataModel.moduleName])
        {
            [groupKeys addObject:group.key];
        }
    }
    /* End PBXGroup section */
    
    /* Begin PBXBuildFile section */
    NSMutableArray *sourcesKeys = [NSMutableArray array];
    for (PBXBuildFile* buildFile in _buildFilesArr)
    {
        NSDictionary *insertBuildFile;
        NSDictionary *insertFileRef;
        
        if ([buildFile.fileName containsString:@".m"])
        {
            insertBuildFile = @{
                                  @"isa":@"PBXBuildFile",
                                  @"fileRef":buildFile.fileRef,
                                  };
            insertFileRef = @{
                              @"isa":@"PBXFileReference",
                              @"fileEncoding":@4,
                              @"lastKnownFileType":@"sourcecode.c.objc",
                              @"path":buildFile.fileName,
                              @"sourceTree":@"<group>",
                              };
            [sourcesKeys addObject:buildFile.key];
            [_objectsDict setValue:insertBuildFile forKey:buildFile.key];
        }
        else
        {
            insertFileRef = @{
                              @"isa":@"PBXFileReference",
                              @"fileEncoding":@4,
                              @"lastKnownFileType":@"sourcecode.c.h",
                              @"path":buildFile.fileName,
                              @"sourceTree":@"<group>",
                              };
        }
        
        
        [_objectsDict setValue:insertFileRef forKey:buildFile.fileRef];
    }
    /* End PBXBuildFile section */
    
    NSString *groupPath;
    if ([_busiName isEqualToString:@"Theme/ThemeVO"])
    {
        groupPath = @"ThemeVO";
    }
    else
    {
        groupPath = _busiName;
    }
    [_objectsDict enumerateKeysAndObjectsUsingBlock:^(NSString *uid, NSDictionary *objDict, BOOL *stop) {
        /* Begin PBXGroup section */
        if ([objDict[@"path"] isEqualToString:groupPath] || [objDict[@"path"] isEqualToString:[NSString stringWithFormat:@"%@/%@",_originDataModel.rootFile,groupPath]])
        {
            if ( [objDict valueForKey:@"path"] )
            {
                NSArray *arr = objDict[@"children"];
                NSArray *childrenArr = [arr arrayByAddingObjectsFromArray:groupKeys];
                [objDict setValue:childrenArr forKey:@"children"];
            }
        }
        /* End PBXGroup section */
        
        /* Begin PBXSourcesBuildPhase section */
        else if ([objDict[@"isa"] isEqualToString:@"PBXSourcesBuildPhase"])
        {
            NSArray *arr = objDict[@"files"];
            NSArray *filesArr = [arr arrayByAddingObjectsFromArray:sourcesKeys];
            [objDict setValue:filesArr forKey:@"files"];
        }
        /* End PBXSourcesBuildPhase section */
    }];
    [_allDataDict setValue:_objectsDict forKey:@"objects"];
    
    NSString *outputPath = _url.path;
    [_allDataDict writeToFile:outputPath  atomically:YES];
}

+ (void)customPbxprojInsertGroupAndClass:(NSURL*)url outputPath:(NSString*)outputPath
{
    NSArray *busiNameArr = @[@"View",@"Controller",@"Theme/ThemeVO"];
    for (int i = 0; i < 3; i ++) {
        ProjectBuild *projectBuild = [[ProjectBuild alloc]init];
        projectBuild.busiName = busiNameArr[i];
        [projectBuild customPbxprojInsertGroupAndClass:url outputPath:outputPath];
    }
    
}


@end
