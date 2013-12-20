//
//  HouseInfo.h
//  XiFangTong
//
//  Created by issuser on 13-8-20.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//
/*
 <NewDataSet xmlns="">
 <ds diffgr:id="ds1" msdata:rowOrder="0">
 <ID>382</ID>
 <b_FullName>观山名筑</b_FullName>
 <b_ShortName>观山名筑</b_ShortName>
 <b_ReferencePrice>沿河叠加别墅155㎡户型，总价210万起；二期&amp;#8226;</b_ReferencePrice>
 <b_BuildAddress>无锡市滨湖区高浪路（由华清路向西300米）</b_BuildAddress>
 <b_Opened>1</b_Opened>
 <b_FinishDate>2012年3月（B地块别墅），2012年9月（B地块高层），2013年年中（A地块高层）；2013年11月（C地块高层）；2014年7月（三期高层14#）</b_FinishDate>
 <b_Tag>地铁配套 新兴区域</b_Tag>
 <b_MarketComment>    （点评）观山名筑，坐落于太湖新城中心区域，东近华清路，西望南湖大道，北靠高浪路，南邻观山路；项目占地近563亩，总建筑面积近80万平方米，总户数约5000户左右，由无锡兴想房地产开发有限公司投资开发。
 社区规划
 　　观山名筑共分为A、B、C三个地块开发，项目首期推出的B地块房源已经进入销售尾声，目前在售房源位于A地块及C地块。其中A地块二期城岸总占面为57854平米，总建面为182956平米。其上涵盖1幢31层高层、2幢32层高层、5幢9层小高层及1幢24层酒店公寓。二期·城岸，是三个地块中位居最北面的一个，西邻地铁一号线，东毗蠡河景观生态河道长廊，社区内有园林意境的中庭景观生活，而在配套上，A地块规划有住宅商铺、大型超市以及星级酒店，集合百货、餐饮、健身、美容等多种功能于一体，可以更为全面地提供业主便捷、品质的生活。
 目前同步销售中的C地块是整个项目中占地面积最大的一个，占地面积约为20万方，总建面约为47万方，涵盖高层、小高层及别墅三种业态。C地块临近观山路，位于整个观山名筑项目的最内侧。C地块定位稍高，而为了配合C地块较为高端的定位，开发商在该地块中规划了会所、一所18班制的双语幼儿园及建面近2000平米的商业街。除了配套设施的相对完善，三期社区中的水景也颇多，背依天然的蠡河生态长廊，单单是社区内部人工打造的水域面积占比就达20%。因而三期社区中的低密度房源占比也较大。
 周边配套
 观山名筑毗邻太湖新城大学城，周边教育配套非常齐全，有江南大学、太湖高级中学、外国语学校、华庄中学、龙清小学和落霞小学等等；但就目前的生活配套而言，略有欠缺，待到周边的众多大型社区建成交付后，可以得到改观。
 随着滨湖区科技型新城区建成，与大学城形成产业集聚效应，区域人文动力亦将不断累积；加上无锡快速内环、蠡湖隧道建成通车，G1快速内环公交线、地铁1号线等便民交通计划的实施，观山名筑所拥有的区域价值将得到不断地提升。
 </b_MarketComment>
 <b_BuildTypeShowIntro>一期别墅：160~300㎡；二期小高层6#、10#楼：115㎡；三期高层14#楼：85㎡、129㎡；一期沿街商铺：90㎡~400㎡</b_BuildTypeShowIntro>
 <lng>120.3382</lng>
 <lat>31.508860000000002</lat>
 <b_Support>超市：易初莲花  好又多，家乐福 联华超市；
 医院：无锡人民医院  华庄医院  扬名医院
 学校: 外国语学校   江南大学   太湖高级中学   华庄初级中学
 落霞小学     东绛实验小学    华庄幼儿园
 酒店：天都花园大酒店  红星饭店  蓝天新港大酒店
 银行：农业银行  工商银行  建设银行
 公园：面积达1000亩的金匮公园
 </b_Support>
 <b_ManageCorporation>无锡市怡庭物业管理有限公司（B区）</b_ManageCorporation>
 <b_ManageMoney>1.5元/平米/月</b_ManageMoney>
 <b_Cubage>1.8</b_Cubage>
 <b_GreenRate>46</b_GreenRate>
 <b_Traffic>地铁1号线、760路、38路、128路、113路、503路</b_Traffic>
 <b_DistrictID>4</b_DistrictID>
 <b_BuildTypeCode>3,7</b_BuildTypeCode>
 <b_District>滨湖区</b_District>
 <avgPrice>7200</avgPrice>
 <LogoPath>200912/01/92064462296490.jpg</LogoPath>
 <ImagePath>201304/08/197802180368425.jpg</ImagePath>
 <Intro>售楼处洽谈</Intro>
 <Tuan>三期：86㎡8千抵2万
 三期：129㎡1万抵3万</Tuan>
 <ActIntro />
 </ds>
 </NewDataSet>
 </diffgr:diffgram>
 </DataSet>
 
 
 
 */
#import <Foundation/Foundation.h>
#import "DDXML.h"
#import "DDXMLElement.h"
#import "DDXMLElementAdditions.h"

@interface HouseInfo : NSObject

@property (copy, nonatomic) NSString  *houseID;
@property (copy, nonatomic) NSString  *fullName;
@property (copy, nonatomic) NSString  *shortName;
@property (copy, nonatomic) NSString  *referencePrice;
@property (copy, nonatomic) NSString  *buildAddress;
@property (copy, nonatomic) NSString  *opened;
@property (copy, nonatomic) NSString  *finishDate;
@property (copy, nonatomic) NSString  *tag;
@property (copy, nonatomic) NSString  *maketComment;
@property (copy, nonatomic) NSString  *buildTypeShowIntro;
@property (copy, nonatomic) NSString  *lng;
@property (copy, nonatomic) NSString  *lat;
@property (copy, nonatomic) NSString  *support;
@property (copy, nonatomic) NSString  *manageCorporation;
@property (copy, nonatomic) NSString  *manageMoney;
@property (copy, nonatomic) NSString  *cubage;
@property (copy, nonatomic) NSString  *greenRate;
@property (copy, nonatomic) NSString  *traffic;
@property (copy, nonatomic) NSString  *buildTypeCode;
@property (copy, nonatomic) NSString  *districtID;
@property (copy, nonatomic) NSString  *district;
@property (copy, nonatomic) NSString  *avgPrice;
@property (copy, nonatomic) NSString  *logoPath;
@property (copy, nonatomic) NSString  *imagePath;
@property (copy, nonatomic) NSString  *intro;
@property (copy, nonatomic) NSString  *tuan;
@property (copy, nonatomic) NSString  *actIntro;
@property (copy, nonatomic) NSString  *rowid;
-(id)initWithDDXMLElement:(DDXMLElement *)element;

@end
