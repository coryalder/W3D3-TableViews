//
//  ViewController.m
//  TableViews
//
//  Created by Cory Alder on 2015-06-24.
//  Copyright (c) 2015 Cory Alder. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *seasons;
//@property (nonatomic, strong) NSArray *episodes;

@end

@implementation ViewController

- (IBAction)reloadTableView:(id)sender {
    
    [self loadData];
    [self.tableView reloadData];
}


-(void)loadData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"episodelist" ofType:@"json"];
    
    NSData *episodeData = [NSData dataWithContentsOfFile:path];
    
    NSError *error = nil;
    
    NSMutableArray *episodes = [NSJSONSerialization JSONObjectWithData:episodeData options:NSJSONReadingMutableContainers error:&error];
    
    if (!episodes) {
        NSLog(@"error loading episode data %@", error);
    }
    
    self.seasons = episodes;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.seasons count];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *aSeason = self.seasons[section];
    return [aSeason count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EpisodeCell" forIndexPath:indexPath];
    
    NSArray *aSeason = self.seasons[indexPath.section];
    
    cell.textLabel.text = aSeason[indexPath.row];

    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Season %li", section + 1];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

//    if (indexPath.section == 0) {
//        return NO;
//    }
    
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *season = self.seasons[indexPath.section];
        [season removeObjectAtIndex:indexPath.row];
        
        NSArray *indexPathsToDelete = @[indexPath];
        [tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } else {
        
    }
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    segue.destinationViewController;
    

}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    NSArray *aSeason = self.seasons[indexPath.section];
//    
//    NSString *episodeName = aSeason[indexPath.row];
//    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:episodeName message:@"is a good episode" preferredStyle:(UIAlertControllerStyleAlert)];
//    
//    [self presentViewController:alert animated:YES completion:nil];
//    
//    NSLog(@"Selected episode %@", episodeName);
//
//}


//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//}

@end
