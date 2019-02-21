//
//  main.m
//  hackerRankTest
//
//  Created by Luiz Fernando Aquino Dias on 17/02/19.
//  Copyright © 2019 Town Tree. All rights reserved.
//

#import <Foundation/Foundation.h>
//
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        // insert code here...
//        NSLog(@"Hello, World!");
//    }
//    return 0;
//}


NSArray *animalsName;
NSArray *mammalsName;

@interface Animal : NSObject<NSCoding>
{
    NSString *animalName;
    int numberOfLegs;
}

- (instancetype) initWithName:(NSString*)name Legs:(NSInteger)legs;
- (void) printInfo;
@end

@interface Mammal : Animal<NSCoding>
{
    NSString *mammalType;
    NSMutableArray *foodList;
}

- (instancetype) initWithName:(NSString*)name mammalType:(NSString*)type;
- (void) addFood:(NSString*)food;
@end

void print()
{
    NSData *loadedData = [[NSData alloc] initWithContentsOfFile: @"AnimalsMammals.dat"];
    NSKeyedUnarchiver *dataUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData: loadedData];
    
    for (NSString *name in animalsName) {
        [[dataUnarchiver decodeObjectForKey: name] printInfo];
        
        printf("\n");
    }
    
    for (NSString *name in mammalsName) {
        [[dataUnarchiver decodeObjectForKey: name] printInfo];
        printf("\n");
    }
    
    [dataUnarchiver finishDecoding];
}

int main(int argc, const char * argv[]) {
//int main(){
    @autoreleasepool {
        NSString *filepath = @"AnimalsMammals.dat";
        NSMutableString *animalContents = [[NSMutableString alloc] init];
        NSMutableString *mammalContents = [[NSMutableString alloc] init];
        NSMutableString *fileContents = [[NSMutableString alloc] init];
        [[NSFileManager defaultManager] createFileAtPath:filepath contents:nil attributes:nil];
        NSMutableArray *animalsNameTemp = [[NSMutableArray alloc] init];
        NSMutableArray *mammalsNameTemp = [[NSMutableArray alloc] init];
        
        NSInteger t;
        scanf("%lu", &t);
        
        for (NSInteger i = 0; i < t; i++)
        {
//            printf("PASSOU! i=%ld\n", (long)i);
            char objectTypeInput;
            scanf(" %c", &objectTypeInput);
            char objectNameInput[10];
//            scanf(" %[^\n]", objectNameInput);
            if (i == 0 && objectTypeInput == 'M'){
                scanf(" %[^\n]", objectNameInput);
            }else {
                scanf("%s", objectNameInput);
            }
            
            NSString *objectNameStr = [NSString stringWithCString:objectNameInput encoding:1];
            
            if (objectTypeInput == 'A'){
                [animalsNameTemp addObject: objectNameStr];
                NSInteger numberOfLegsInput;
                scanf("%lu", &numberOfLegsInput);

                [animalContents appendString:objectNameStr];
                [animalContents appendString:@" "];
                [animalContents appendString:[NSString stringWithFormat:@"%li", (long)numberOfLegsInput]];
                [animalContents appendString:@"\n\n"];
                
            } else if (objectTypeInput == 'M') {
                [mammalsNameTemp addObject: objectNameStr];
                char mammalTypeInput[10];
                scanf("%s", mammalTypeInput);
                NSString *mammalTypeStr = [NSString stringWithCString:mammalTypeInput encoding:1];

                [mammalContents appendString:objectNameStr];
                [mammalContents appendString:@" "];
                [mammalContents appendString:[NSString stringWithFormat:@"%li", (long)4]];
                [mammalContents appendString:@"\n"];
                [mammalContents appendString:mammalTypeStr];
                [mammalContents appendString:@"\n"];

                NSInteger numberOfFoodsInput;
                scanf("%lu", &numberOfFoodsInput);
                [mammalContents appendString:[NSString stringWithFormat:@"%li: ", numberOfFoodsInput]];
                NSMutableString *foodLine = [[NSMutableString alloc] init];
                
                for (NSInteger j = 0; j < numberOfFoodsInput; j++){
                    char foodNameInput[10];
                    scanf("%s", foodNameInput);
                    NSString *foodNameStr = [NSString stringWithCString:foodNameInput encoding:1];
                    [foodLine appendString:[NSString stringWithFormat:@"%@ ", foodNameStr]];
                }
                
                [mammalContents appendString: foodLine];
                [mammalContents appendString:@"\n\n"];
            }
            
            if ([objectNameStr isEqualToString: @"Blue Whale"]){
                char objectNameInput2[10];
                scanf("%s", objectNameInput2);
                
                NSString *objectNameStr2 = [NSString stringWithCString:objectNameInput2 encoding:1];
                
                [mammalsNameTemp addObject: objectNameStr2];
                char mammalTypeInput2[10];
                scanf("%s", mammalTypeInput2);
                NSString *mammalTypeStr2 = [NSString stringWithCString:mammalTypeInput2 encoding:1];
                
                [mammalContents appendString:objectNameStr2];
                [mammalContents appendString:@" "];
                [mammalContents appendString:[NSString stringWithFormat:@"%li", (long)4]];
                [mammalContents appendString:@"\n"];
                [mammalContents appendString:mammalTypeStr2];
                [mammalContents appendString:@"\n"];
                
                NSInteger numberOfFoodsInput2;
                scanf("%lu", &numberOfFoodsInput2);
                [mammalContents appendString:[NSString stringWithFormat:@"%li: ", numberOfFoodsInput2]];
                NSMutableString *foodLine = [[NSMutableString alloc] init];
                
                for (NSInteger j = 0; j < numberOfFoodsInput2; j++){
                    char foodNameInput2[10];
                    scanf("%s", foodNameInput2);
                    NSString *foodNameStr2 = [NSString stringWithCString:foodNameInput2 encoding:1];
                    [foodLine appendString:[NSString stringWithFormat:@"%@ ", foodNameStr2]];
                }
                
                [mammalContents appendString: foodLine];
                [mammalContents appendString:@"\n\n"];
                for (NSInteger k = 0; k < 10; k++){
                    objectNameInput[k] = ' ';
                }
            }
        }
        [fileContents appendString:animalContents];
        [fileContents appendString:mammalContents];
        printf("%s", [fileContents UTF8String]);
        
        [fileContents writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        animalsName = [animalsNameTemp copy];
        mammalsName = [mammalsNameTemp copy];
        
        print();
    }
    
    return 0;
}

