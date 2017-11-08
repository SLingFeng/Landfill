//
//  SLFSpeak.m
//  
//
//  Created by Hale on 17/3/22.
//  Copyright © 2017年 SADF. All rights reserved.
//

#import "SLFSpeak.h"


@implementation SLFSpeak

singleton_implemetntion(SLFSpeak)

- (NSArray<AVSpeechSynthesisVoice *> *)laungeVoices {
    if (_laungeVoices == nil) {
        _laungeVoices = @[
                          //美式英语
                          [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"],
                          //英式英语
                          [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"],
                          //中文
                          [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]
                          ];
    }
    return _laungeVoices;
}

- (AVSpeechSynthesizer *)synthesizer {
    if (_synthesizer == nil) {
        _synthesizer = [[AVSpeechSynthesizer alloc] init];
        _synthesizer.delegate = self;
        //  不设置可能因为手机设置而听不到声音
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        NSError *error;
        if (![audioSession setCategory:AVAudioSessionCategoryPlayback error:&error]) {
            NSLog(@"set category error : %@", error);
        }
        if (![audioSession setActive:YES error:&error]) {
            NSLog(@"set active error: %@", error);
        }
    }
    return _synthesizer;
}

#pragma mark - 事件处理 
/** 语音播放 */
- (void)playVoice {
    _isStop = NO;
    if (_playArr) {
        NSString * str = [self getSpeakString:_playArr[self.nextSpeak]];
//            dispatch_queue_t queue = dispatch_queue_create("com.example.MyQueue", DISPATCH_QUEUE_SERIAL);
//            dispatch_sync(queue, ^{
                //创建一个会话
                AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:str];
                //选择语言发音的类别，如果有中文，一定要选择中文，要不然无法播放语音
                utterance.voice = self.laungeVoices[2];
                //播放语言的速率，值越大，播放速率越快
                utterance.rate = 0.45;
                //音调  --  为语句指定pitchMultiplier ，可以在播放特定语句时改变声音的音调、pitchMultiplier的允许值一般介于0.5(低音调)和2.0(高音调)之间
                //    utterance.pitchMultiplier = 0.8f;
                //让语音合成器在播放下一句之前有短暂时间的暂停，也可以类似的设置preUtteranceDelay
                utterance.postUtteranceDelay = 0.8f;
                //    //播放语言
                [self.synthesizer speakUtterance:utterance];
//            });
        }
//        12345
//        23456
//        62345
//        34562
}
/** 暂停语音播放/回复语音播放 */
- (void)playAndPause {
    if (self.synthesizer.isPaused == YES) {
        //暂停状态
        //继续播放
        [self.synthesizer continueSpeaking];
    }else {
        //现在在播放
        //立即暂停播放
        [self.synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
}
/** 停止播放语音 */
- (void)stopPlayVoice {
    if (self.synthesizer.isSpeaking) {
//        self.playArr = nil;
        _nextSpeak = 0;
        _isStop = YES;
        //正在语音播放
        //立即停止播放语音
        [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
}
/**********************AVSpeechSynthesizerDelegate(代理方法)***********************/
#pragma mark - AVSpeechSynthesizerDelegate(代理方法)
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"开始播放语音的时候调用");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    if (self.didFinishSpeech) {
        self.didFinishSpeech();
    }
    NSLog(@"语音播放结束的时候调用");
    self.nextSpeak += 1;
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"暂停语音播放的时候调用");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"继续播放语音的时候调用");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"取消语音播放的时候调用");
    self.nextSpeak = 0;
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance {
    /** 将要播放的语音文字 */
    NSString *willSpeakRangeOfSpeechString = [utterance.speechString substringWithRange:characterRange];
    NSLog(@"即将播放的语音文字:%@",willSpeakRangeOfSpeechString);
}

- (void)setNextSpeak:(NSInteger)nextSpeak {
    if (nextSpeak >= 5) {
        nextSpeak = 0;
    }else {
        _nextSpeak = nextSpeak;
    }
    if (_isStop) {
        return;
    }
    [self playVoice];
}

- (void)setPlayArr:(NSMutableArray *)playArr {
    
    if (kArrayIsEmpty(_playArr)) {
        _playArr = playArr;
        return;
    }
    if (kArrayIsEmpty(playArr)) {
        return;
    }
    if ([_playArr[0] isKindOfClass:[YGBDemandListOrderJjinfoModel class]]) {
        if (![playArr[0] isKindOfClass:[YGBDemandListOrderJjinfoModel class]]) {
            _playArr = playArr;
            return;
        }
    }else {
        if (![playArr[0] isKindOfClass:[YGBDemandListOrderYginfoModel class]]) {
            _playArr = playArr;
            return;
        }
    }
    
    NSMutableArray *oldRemove = [_playArr mutableCopy];
    NSMutableArray *remove = [playArr mutableCopy];
    //筛选不一样的
    if ([[GVUserDefaults standardUserDefaults] typeYgOrJj]) {
        
        [_playArr enumerateObjectsUsingBlock:^(YGBDemandListOrderJjinfoModel * oldModel, NSUInteger idx, BOOL * _Nonnull stop) {
            __block BOOL isEuql = YES;
            __block YGBDemandListOrderJjinfoModel * indexM;
            
            [playArr enumerateObjectsUsingBlock:^(YGBDemandListOrderJjinfoModel * model, NSUInteger newidx, BOOL * _Nonnull newstop) {
                if (model.ygbdgid != oldModel.ygbdgid) {
                    //被抢的替换 新
                    isEuql = NO;
                }else {
                    //相同跳出
                    isEuql = YES;
                    indexM = model;
                    *newstop = YES;
                }
            }];
            
            if (isEuql == NO) {
                [oldRemove removeObject:oldModel];
            }else {
                [remove removeObject:indexM];
            }
        }];
        
        for (YGBDemandListOrderJjinfoModel *model in remove) {
            [oldRemove addObject:model];
        }
    }else {
        //用工
        [_playArr enumerateObjectsUsingBlock:^(YGBDemandListOrderYginfoModel * oldModel, NSUInteger idx, BOOL * _Nonnull stop) {
            __block BOOL isEuql = YES;
            __block YGBDemandListOrderYginfoModel * indexM;
            
            [playArr enumerateObjectsUsingBlock:^(YGBDemandListOrderYginfoModel * model, NSUInteger newidx, BOOL * _Nonnull newstop) {
                if (model.ygbdid != oldModel.ygbdid) {
                    //被抢的替换 新
                    isEuql = NO;
                }else {
                    //相同跳出
                    isEuql = YES;
                    indexM = model;
                    *newstop = YES;
                }
            }];
            
            if (isEuql == NO) {
                [oldRemove removeObject:oldModel];
            }else {
                [remove removeObject:indexM];
            }
        }];
        
        for (YGBDemandListOrderYginfoModel *model in remove) {
            [oldRemove addObject:model];
        }
    }
    
    [oldRemove sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([[GVUserDefaults standardUserDefaults] typeYgOrJj]) {
            YGBDemandListOrderJjinfoModel *model = obj1;
            YGBDemandListOrderJjinfoModel *model2 = obj2;
            if (model.ygbdgid.integerValue > model2.ygbdgid.integerValue) {
                return NSOrderedAscending;
            }
            return NSOrderedDescending;
        }else {
            YGBDemandListOrderYginfoModel *model = obj1;
            YGBDemandListOrderYginfoModel *model2 = obj2;
            if (model.ygbdid.integerValue > model2.ygbdid.integerValue) {
                return NSOrderedAscending;
            }
            return NSOrderedDescending;
        }
    }];
    
    _playArr = [oldRemove mutableCopy];
    self.nextSpeak = 0;
}

- (NSString *)getSpeakString:(id)obj {
    //生成文字
    if ([obj isKindOfClass:[YGBDemandListOrderJjinfoModel class]]) {
        
        YGBDemandListOrderJjinfoModel *model = obj;
        return [NSString stringWithFormat:@"需要学历：%@,上课时间为%@,上课地点:%@,上课天数:%@天", model.ygbeducation, model.ygbdgmounttime, [NSString stringWithFormat:@"%@%@%@%@", model.ygbdgprovince, model.ygbdgcity, model.ygbdgarea,  model.ygbdgaddress], model.ygbdgdays];
    }else if ([obj isKindOfClass:[YGBDemandListOrderYginfoModel class]]) {
        
        YGBDemandListOrderYginfoModel *model = obj;
        return [NSString stringWithFormat:@"需要工种：%@,施工时间为%@,施工地点:%@，施工天数:%@天", model.ygblcname, model.ygbdtimearrival, [NSString stringWithFormat:@"%@%@%@%@", model.ygbdprovince, model.ygbdcity, model.ygbdarea,  model.ygbdaddress], model.ygbddays];
    }
    return @"数据获取错误";
}


@end
