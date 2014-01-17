//
//  ViewController.m
//  Ex226_maker_tmap
//
//  Created by SDT-1 on 2014. 1. 17..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#import "TMapView.h"
#import "DetailViewController.h"
#define TOOLBAR_HIGHT 60
#define APP_KEY @"230febe2-ce30-303c-a8d1-827c4104161b"

@interface ViewController ()<TMapViewDelegate>
@property (strong,nonatomic)TMapView *mapView;

@end

@implementation ViewController

-(void)onClick:(TMapPoint *)TMP{
    NSLog(@"눌린 위치: %@",TMP);
}

-(void)onLongClick:(TMapPoint *)TMP{
    NSLog(@" 길게 눌린 위치: %@",TMP);

}

-(void)onCalloutRightbuttonClick:(TMapMarkerItem *)markerItem{
    NSLog(@"marker id : %@",[markerItem getID]);
    if([@"T-ACADEMY" isEqualToString:[markerItem getID]]){
        // 넘어가는 코드
        DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
        detailVC.urlStr = @"http://tacademy.co.kr";
        [self presentViewController:detailVC animated:YES completion:nil];
    }
}

-(void)onCustomObjectClick:(TMapObject *)obj{
    if([obj isKindOfClass:[TMapMarkerItem class]]){
        TMapMarkerItem *maker = (TMapMarkerItem *)obj;
        NSLog(@"marker clicked %@",[maker getID]);
    }
}

-(IBAction)addOverlay:(id)sender{
    CLLocationCoordinate2D coord[5] = {
        CLLocationCoordinate2DMake(37.460143, 126.914062),
        CLLocationCoordinate2DMake(37.469136, 126.981869),
        CLLocationCoordinate2DMake(37.437930, 126.989937),
        CLLocationCoordinate2DMake(37.413255, 126.959038),
        CLLocationCoordinate2DMake(37.426752, 126.913548),
        
    };
    
    
    TMapPolygon *polygon = [[TMapPolygon alloc] init];
    [polygon setLineColor:[UIColor redColor]];
    
    [polygon setPolygonAlpha:0];
    [polygon setLineWidth:8.0];
    
    for (int i = 5; i < 5; i++) {
        [polygon addPolygonPoint:[TMapPoint mapPointWithCoordinate:coord[i]]];
    }
    
    [_mapView addTMapPolygonID:@"관악산" Polygon:polygon];

}

-(IBAction)addMarker:(id)sender{
    NSString *itemID = @"T-ACADEMY";
    TMapPoint *point = [[TMapPoint alloc] initWithLon:126.96 Lat:37.466];
    TMapMarkerItem *marker = [[TMapMarkerItem alloc] initWithTMapPoint:point];
    [marker setIcon:[UIImage imageNamed:@"ball1.png"]];
    
    [marker setCanShowCallout:YES];
    [marker setCalloutTitle:@"티 아카데미"];
    [marker setCalloutRightButtonImage:[UIImage imageNamed:@"ball2.png"]];
    [_mapView addTMapMarkerItemID:itemID Marker:marker];
}

-(IBAction)moveTOseoul:(id)sender{
    
    TMapPoint *centerPoint = [[TMapPoint alloc] initWithLon:126.96 Lat:37.446];
    [_mapView setCenterPoint:centerPoint];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect rect = CGRectMake(0, TOOLBAR_HIGHT, 320, 300);
    _mapView = [[TMapView alloc] initWithFrame:rect];
    [_mapView setSKPMapApiKey:APP_KEY];
    _mapView.zoomLevel = 12.0;
    _mapView.delegate =self;
    [self.view addSubview:_mapView];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
