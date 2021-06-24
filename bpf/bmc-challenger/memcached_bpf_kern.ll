; ModuleID = 'memcached_bpf_kern.c'
source_filename = "memcached_bpf_kern.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32, i32, i32 }
%struct.anon = type { [6 x i32]*, i32*, %struct.memcached_key*, [31 x i32]* }
%struct.memcached_key = type { i32, [250 x i8], i32 }
%struct.anon.0 = type { [2 x i32]*, i32*, %struct.memcached_cache_entry*, [2777777 x i32]* }
%struct.memcached_cache_entry = type { %struct.bpf_spin_lock, i32, i8, i32, i32, [403 x i8] }
%struct.bpf_spin_lock = type { i32 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.iphdr = type { i8, i8, i16, i16, i16, i8, i8, i16, i32, i32 }
%struct.udphdr = type { i16, i16, i16, i16 }
%struct.tcphdr = type { i16, i16, i32, i32, i16, i16, i16, i16 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.__sk_buff = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, [5 x i32], i32, i32, i32, i32, i32, i32, i32, i32, [4 x i32], [4 x i32], i32, i32, i32, %union.anon, i64, i32, i32, %union.anon.4 }
%union.anon = type { %struct.bpf_flow_keys* }
%struct.bpf_flow_keys = type { i16, i16, i16, i8, i8, i8, i8, i16, i16, i16, %union.anon.1 }
%union.anon.1 = type { %struct.anon.3 }
%struct.anon.3 = type { [4 x i32], [4 x i32] }
%union.anon.4 = type { %struct.bpf_sock* }
%struct.bpf_sock = type { i32, i32, i32, i32, i32, i32, i32, [4 x i32], i32, i32, i32, [4 x i32], i32 }

@map_parsing_context = dso_local global %struct.bpf_map_def { i32 6, i32 4, i32 12, i32 1, i32 0, i32 0, i32 0 }, section "maps", align 4, !dbg !0
@map_stats = dso_local global %struct.bpf_map_def { i32 6, i32 4, i32 48, i32 1, i32 0, i32 0, i32 0 }, section "maps", align 4, !dbg !56
@map_progs_xdp = dso_local global %struct.bpf_map_def { i32 3, i32 4, i32 4, i32 4, i32 0, i32 0, i32 0 }, section "maps", align 4, !dbg !68
@map_progs_tc = dso_local global %struct.bpf_map_def { i32 3, i32 4, i32 4, i32 1, i32 0, i32 0, i32 0 }, section "maps", align 4, !dbg !70
@map_keys = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !111
@map_kcache = dso_local global %struct.anon.0 zeroinitializer, section ".maps", align 8, !dbg !77
@__const.xdp_memcached_rx_set_parse_main.____fmt = private unnamed_addr constant [72 x i8] c"Error: SET found but it couldn't be used to invalidate the cache entry\0A\00", align 16
@__const.tc_memcached_tx_get_parse_main.____fmt = private unnamed_addr constant [70 x i8] c"Info: New challeger : entry->hash = %u, entry->valid = %u, hash2 = %u\00", align 16
@__const.tc_memcached_tx_get_parse_main.____fmt.2 = private unnamed_addr constant [63 x i8] c"Info: valid--: entry->hash = %u, entry->valid = %u, hash2 = %u\00", align 16
@__const.tc_memcached_tx_get_parse_main.____fmt.4 = private unnamed_addr constant [54 x i8] c"Info: entry->hash = %u, entry->valid = %u, hash2 = %u\00", align 16
@__const.tc_memcached_tx_get_parse_main.____fmt.5 = private unnamed_addr constant [59 x i8] c"Info: entry->challenger = %u, hash = %u, entry->data = %i\0A\00", align 16
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !72
@llvm.used = appending global [14 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.anon.0* @map_kcache to i8*), i8* bitcast (%struct.anon* @map_keys to i8*), i8* bitcast (%struct.bpf_map_def* @map_parsing_context to i8*), i8* bitcast (%struct.bpf_map_def* @map_progs_tc to i8*), i8* bitcast (%struct.bpf_map_def* @map_progs_xdp to i8*), i8* bitcast (%struct.bpf_map_def* @map_stats to i8*), i8* bitcast (i32 (%struct.__sk_buff*)* @tc_memcached_tx_get_parse_main to i8*), i8* bitcast (i32 (%struct.__sk_buff*)* @tc_memcached_tx_main to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_memcached_rx_get_adjust_pkt_main to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_memcached_rx_get_parse_main to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_memcached_rx_get_write_pkt_main to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_memcached_rx_main to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_memcached_rx_set_parse_main to i8*)], section "llvm.metadata"

; Function Attrs: nounwind uwtable
define dso_local i32 @xdp_memcached_rx_main(%struct.xdp_md*) #0 section "xdp_memcached_rx" !dbg !175 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !187, metadata !DIExpression()), !dbg !252
  %3 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !253
  %4 = load i32, i32* %3, align 4, !dbg !253, !tbaa !254
  %5 = zext i32 %4 to i64, !dbg !259
  %6 = inttoptr i64 %5 to i8*, !dbg !260
  call void @llvm.dbg.value(metadata i8* %6, metadata !188, metadata !DIExpression()), !dbg !252
  %7 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !261
  %8 = load i32, i32* %7, align 4, !dbg !261, !tbaa !262
  %9 = zext i32 %8 to i64, !dbg !263
  %10 = inttoptr i64 %9 to i8*, !dbg !264
  call void @llvm.dbg.value(metadata i8* %10, metadata !189, metadata !DIExpression()), !dbg !252
  call void @llvm.dbg.value(metadata i8* %10, metadata !190, metadata !DIExpression()), !dbg !252
  call void @llvm.dbg.value(metadata i8* %10, metadata !200, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !252
  call void @llvm.dbg.value(metadata i8* %10, metadata !217, metadata !DIExpression(DW_OP_plus_uconst, 34, DW_OP_stack_value)), !dbg !252
  %11 = getelementptr inbounds i8, i8* %10, i64 34, !dbg !265
  %12 = bitcast i8* %11 to %struct.iphdr*, !dbg !265
  %13 = inttoptr i64 %5 to %struct.iphdr*, !dbg !267
  %14 = icmp ugt %struct.iphdr* %12, %13, !dbg !268
  br i1 %14, label %95, label %15, !dbg !269

15:                                               ; preds = %1
  call void @llvm.dbg.value(metadata i8* %10, metadata !200, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !252
  call void @llvm.dbg.value(metadata i8* %10, metadata !200, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !252
  %16 = getelementptr inbounds i8, i8* %10, i64 23, !dbg !270
  %17 = load i8, i8* %16, align 1, !dbg !270, !tbaa !271
  switch i8 %17, label %95 [
    i8 17, label %18
    i8 6, label %25
  ], !dbg !274

18:                                               ; preds = %15
  call void @llvm.dbg.value(metadata i8* %10, metadata !218, metadata !DIExpression(DW_OP_plus_uconst, 34, DW_OP_stack_value)), !dbg !252
  %19 = getelementptr inbounds i8, i8* %10, i64 42, !dbg !275
  %20 = bitcast i8* %19 to %struct.udphdr*, !dbg !275
  %21 = inttoptr i64 %5 to %struct.udphdr*, !dbg !278
  %22 = icmp ugt %struct.udphdr* %20, %21, !dbg !279
  br i1 %22, label %95, label %23, !dbg !280

23:                                               ; preds = %18
  call void @llvm.dbg.value(metadata i8* %10, metadata !218, metadata !DIExpression(DW_OP_plus_uconst, 34, DW_OP_stack_value)), !dbg !252
  %24 = getelementptr i8, i8* %10, i64 50, !dbg !281
  call void @llvm.dbg.value(metadata i8* %24, metadata !220, metadata !DIExpression()), !dbg !252
  br label %30, !dbg !282

25:                                               ; preds = %15
  call void @llvm.dbg.value(metadata i8* %10, metadata !219, metadata !DIExpression(DW_OP_plus_uconst, 34, DW_OP_stack_value)), !dbg !252
  %26 = getelementptr i8, i8* %10, i64 54, !dbg !283
  %27 = bitcast i8* %26 to %struct.tcphdr*, !dbg !283
  %28 = inttoptr i64 %5 to %struct.tcphdr*, !dbg !285
  %29 = icmp ugt %struct.tcphdr* %27, %28, !dbg !286
  br i1 %29, label %95, label %30, !dbg !287

30:                                               ; preds = %25, %23
  %31 = phi i8* [ %24, %23 ], [ %26, %25 ], !dbg !288
  %32 = getelementptr inbounds i8, i8* %10, i64 36, !dbg !288
  %33 = bitcast i8* %32 to i16*, !dbg !288
  %34 = load i16, i16* %33, align 2, !dbg !288, !tbaa !289
  call void @llvm.dbg.value(metadata i8* %31, metadata !220, metadata !DIExpression()), !dbg !252
  call void @llvm.dbg.value(metadata i16 %34, metadata !221, metadata !DIExpression()), !dbg !252
  %35 = icmp ne i16 %34, -13525, !dbg !290
  %36 = getelementptr inbounds i8, i8* %31, i64 4, !dbg !291
  %37 = icmp ugt i8* %36, %6, !dbg !292
  %38 = or i1 %35, %37, !dbg !293
  br i1 %38, label %95, label %39, !dbg !293

39:                                               ; preds = %30
  switch i8 %17, label %95 [
    i8 17, label %40
    i8 6, label %93
  ], !dbg !294

40:                                               ; preds = %39
  %41 = load i8, i8* %31, align 1, !dbg !295, !tbaa !296
  %42 = icmp eq i8 %41, 103, !dbg !297
  br i1 %42, label %43, label %95, !dbg !298

43:                                               ; preds = %40
  %44 = getelementptr inbounds i8, i8* %31, i64 1, !dbg !299
  %45 = load i8, i8* %44, align 1, !dbg !299, !tbaa !296
  %46 = icmp eq i8 %45, 101, !dbg !300
  br i1 %46, label %47, label %95, !dbg !301

47:                                               ; preds = %43
  %48 = getelementptr inbounds i8, i8* %31, i64 2, !dbg !302
  %49 = load i8, i8* %48, align 1, !dbg !302, !tbaa !296
  %50 = icmp eq i8 %49, 116, !dbg !303
  br i1 %50, label %51, label %95, !dbg !304

51:                                               ; preds = %47
  %52 = getelementptr inbounds i8, i8* %31, i64 3, !dbg !305
  %53 = load i8, i8* %52, align 1, !dbg !305, !tbaa !296
  %54 = icmp eq i8 %53, 32, !dbg !306
  br i1 %54, label %55, label %95, !dbg !307

55:                                               ; preds = %51
  %56 = bitcast i32* %2 to i8*, !dbg !308
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %56) #3, !dbg !308
  call void @llvm.dbg.value(metadata i32 0, metadata !222, metadata !DIExpression()), !dbg !309
  store i32 0, i32* %2, align 4, !dbg !310, !tbaa !311
  %57 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @map_stats to i8*), i8* nonnull %56) #3, !dbg !312
  call void @llvm.dbg.value(metadata i8* %57, metadata !227, metadata !DIExpression()), !dbg !309
  %58 = icmp eq i8* %57, null, !dbg !313
  br i1 %58, label %92, label %59, !dbg !315

59:                                               ; preds = %55
  call void @llvm.dbg.value(metadata i8* %57, metadata !227, metadata !DIExpression()), !dbg !309
  %60 = bitcast i8* %57 to i32*, !dbg !316
  %61 = load i32, i32* %60, align 4, !dbg !317, !tbaa !318
  %62 = add i32 %61, 1, !dbg !317
  store i32 %62, i32* %60, align 4, !dbg !317, !tbaa !318
  %63 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @map_parsing_context to i8*), i8* nonnull %56) #3, !dbg !320
  call void @llvm.dbg.value(metadata i8* %63, metadata !243, metadata !DIExpression()), !dbg !309
  %64 = icmp eq i8* %63, null, !dbg !321
  br i1 %64, label %92, label %65, !dbg !323

65:                                               ; preds = %59
  %66 = bitcast i8* %63 to i32*, !dbg !324
  store i32 0, i32* %66, align 4, !dbg !325, !tbaa !326
  %67 = getelementptr inbounds i8, i8* %63, i64 4, !dbg !328
  %68 = bitcast i8* %67 to i32*, !dbg !328
  store i32 0, i32* %68, align 4, !dbg !329, !tbaa !330
  %69 = getelementptr inbounds i8, i8* %63, i64 10, !dbg !331
  %70 = bitcast i8* %69 to i16*, !dbg !331
  store i16 0, i16* %70, align 2, !dbg !332, !tbaa !333
  call void @llvm.dbg.value(metadata i32 4, metadata !251, metadata !DIExpression()), !dbg !309
  br label %71, !dbg !334

71:                                               ; preds = %79, %65
  %72 = phi i64 [ 4, %65 ], [ %80, %79 ]
  call void @llvm.dbg.value(metadata i64 %72, metadata !251, metadata !DIExpression()), !dbg !309
  %73 = getelementptr inbounds i8, i8* %31, i64 %72, !dbg !337
  %74 = getelementptr inbounds i8, i8* %73, i64 1, !dbg !338
  %75 = icmp ugt i8* %74, %6, !dbg !339
  br i1 %75, label %82, label %76, !dbg !340

76:                                               ; preds = %71
  %77 = load i8, i8* %73, align 1, !dbg !341, !tbaa !296
  %78 = icmp eq i8 %77, 32, !dbg !342
  br i1 %78, label %79, label %82, !dbg !343

79:                                               ; preds = %76
  %80 = add nuw nsw i64 %72, 1, !dbg !344
  call void @llvm.dbg.value(metadata i32 undef, metadata !251, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !309
  %81 = icmp eq i64 %80, 1500, !dbg !345
  br i1 %81, label %92, label %71, !dbg !334, !llvm.loop !346

82:                                               ; preds = %76, %71
  call void @llvm.dbg.value(metadata i64 %72, metadata !251, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.value(metadata i64 %72, metadata !251, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.value(metadata i64 %72, metadata !251, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.value(metadata i64 %72, metadata !251, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.value(metadata i64 %72, metadata !251, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.value(metadata i64 %72, metadata !251, metadata !DIExpression()), !dbg !309
  %83 = trunc i64 %72 to i32, !dbg !340
  call void @llvm.dbg.value(metadata i64 %72, metadata !251, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.value(metadata i64 %72, metadata !251, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.value(metadata i32 %83, metadata !251, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.value(metadata i32 %83, metadata !251, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.value(metadata i32 %83, metadata !251, metadata !DIExpression()), !dbg !309
  call void @llvm.dbg.value(metadata i32 %83, metadata !251, metadata !DIExpression()), !dbg !309
  %84 = trunc i64 %72 to i16, !dbg !349
  %85 = getelementptr inbounds i8, i8* %63, i64 8, !dbg !352
  %86 = bitcast i8* %85 to i16*, !dbg !352
  store i16 %84, i16* %86, align 4, !dbg !353, !tbaa !354
  %87 = bitcast %struct.xdp_md* %0 to i8*, !dbg !355
  %88 = add nuw nsw i32 %83, 50, !dbg !357
  %89 = call i32 inttoptr (i64 44 to i32 (i8*, i32)*)(i8* %87, i32 %88) #3, !dbg !358
  %90 = icmp eq i32 %89, 0, !dbg !358
  br i1 %90, label %91, label %92, !dbg !359

91:                                               ; preds = %82
  call void inttoptr (i64 12 to void (i8*, i8*, i32)*)(i8* %87, i8* bitcast (%struct.bpf_map_def* @map_progs_xdp to i8*), i32 0) #3, !dbg !360
  br label %92, !dbg !361

92:                                               ; preds = %79, %59, %91, %82, %55
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %56) #3, !dbg !362
  ret i32 2

93:                                               ; preds = %39
  %94 = bitcast %struct.xdp_md* %0 to i8*, !dbg !363
  tail call void inttoptr (i64 12 to void (i8*, i8*, i32)*)(i8* %94, i8* bitcast (%struct.bpf_map_def* @map_progs_xdp to i8*), i32 3) #3, !dbg !366
  br label %95, !dbg !367

95:                                               ; preds = %39, %40, %43, %47, %51, %93, %30, %15, %25, %18, %1
  ret i32 2, !dbg !368
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nounwind uwtable
define dso_local i32 @xdp_memcached_rx_get_parse_main(%struct.xdp_md*) #0 section "xdp_memcached_rx_get_parse" !dbg !369 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !371, metadata !DIExpression()), !dbg !388
  %4 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !389
  %5 = load i32, i32* %4, align 4, !dbg !389, !tbaa !254
  %6 = zext i32 %5 to i64, !dbg !390
  %7 = inttoptr i64 %6 to i8*, !dbg !391
  call void @llvm.dbg.value(metadata i8* %7, metadata !372, metadata !DIExpression()), !dbg !388
  %8 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !392
  %9 = load i32, i32* %8, align 4, !dbg !392, !tbaa !262
  %10 = zext i32 %9 to i64, !dbg !393
  %11 = inttoptr i64 %10 to i8*, !dbg !394
  call void @llvm.dbg.value(metadata i8* %11, metadata !373, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i8* %11, metadata !374, metadata !DIExpression()), !dbg !388
  %12 = bitcast i32* %2 to i8*, !dbg !395
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %12) #3, !dbg !395
  call void @llvm.dbg.value(metadata i32 0, metadata !375, metadata !DIExpression()), !dbg !388
  store i32 0, i32* %2, align 4, !dbg !396, !tbaa !311
  %13 = icmp ult i8* %11, %7, !dbg !397
  br i1 %13, label %14, label %126, !dbg !399

14:                                               ; preds = %1
  %15 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @map_parsing_context to i8*), i8* nonnull %12) #3, !dbg !400
  call void @llvm.dbg.value(metadata i8* %15, metadata !376, metadata !DIExpression()), !dbg !388
  %16 = icmp eq i8* %15, null, !dbg !401
  br i1 %16, label %126, label %17, !dbg !403

17:                                               ; preds = %14
  %18 = bitcast i8* %15 to i32*, !dbg !404
  %19 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @map_keys to i8*), i8* nonnull %15) #3, !dbg !405
  call void @llvm.dbg.value(metadata i8* %19, metadata !377, metadata !DIExpression()), !dbg !388
  %20 = icmp eq i8* %19, null, !dbg !406
  br i1 %20, label %126, label %21, !dbg !408

21:                                               ; preds = %17
  %22 = bitcast i8* %19 to i32*, !dbg !409
  store i32 -2128831035, i32* %22, align 4, !dbg !410, !tbaa !411
  call void @llvm.dbg.value(metadata i32 0, metadata !379, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i32 0, metadata !380, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i32 0, metadata !378, metadata !DIExpression()), !dbg !388
  br label %23, !dbg !413

23:                                               ; preds = %32, %21
  %24 = phi i32 [ -2128831035, %21 ], [ %35, %32 ]
  %25 = phi i64 [ 0, %21 ], [ %37, %32 ]
  %26 = phi i32 [ 0, %21 ], [ %36, %32 ]
  call void @llvm.dbg.value(metadata i32 %26, metadata !380, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i64 %25, metadata !378, metadata !DIExpression()), !dbg !388
  %27 = getelementptr inbounds i8, i8* %11, i64 %25, !dbg !416
  %28 = getelementptr inbounds i8, i8* %27, i64 1, !dbg !417
  %29 = icmp ugt i8* %28, %7, !dbg !418
  br i1 %29, label %41, label %30, !dbg !419

30:                                               ; preds = %23
  %31 = load i8, i8* %27, align 1, !dbg !420, !tbaa !296
  switch i8 %31, label %32 [
    i8 13, label %43
    i8 32, label %39
  ], !dbg !423

32:                                               ; preds = %30
  %33 = sext i8 %31 to i32, !dbg !420
  %34 = xor i32 %24, %33, !dbg !424
  %35 = mul i32 %34, 16777619, !dbg !428
  store i32 %35, i32* %22, align 4, !dbg !428, !tbaa !411
  %36 = add nuw nsw i32 %26, 1, !dbg !429
  %37 = add nuw nsw i64 %25, 1, !dbg !430
  call void @llvm.dbg.value(metadata i32 %36, metadata !380, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i32 %36, metadata !378, metadata !DIExpression()), !dbg !388
  %38 = icmp eq i64 %37, 251, !dbg !431
  br i1 %38, label %45, label %23, !dbg !413, !llvm.loop !432

39:                                               ; preds = %30
  call void @llvm.dbg.value(metadata i64 %25, metadata !378, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i32 %26, metadata !380, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i64 %25, metadata !378, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i32 %26, metadata !380, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i64 %25, metadata !378, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i32 %26, metadata !380, metadata !DIExpression()), !dbg !388
  %40 = trunc i64 %25 to i32, !dbg !419
  call void @llvm.dbg.value(metadata i32 %26, metadata !380, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i32 %26, metadata !380, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i32 %40, metadata !378, metadata !DIExpression()), !dbg !388
  br label %45, !dbg !434

41:                                               ; preds = %23
  call void @llvm.dbg.value(metadata i64 %25, metadata !378, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i32 %26, metadata !380, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i64 %25, metadata !378, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i32 %26, metadata !380, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i64 %25, metadata !378, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i32 %26, metadata !380, metadata !DIExpression()), !dbg !388
  %42 = trunc i64 %25 to i32, !dbg !419
  br label %45, !dbg !434

43:                                               ; preds = %30
  call void @llvm.dbg.value(metadata i64 %25, metadata !378, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i32 %26, metadata !380, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i64 %25, metadata !378, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i32 %26, metadata !380, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i64 %25, metadata !378, metadata !DIExpression()), !dbg !388
  call void @llvm.dbg.value(metadata i32 %26, metadata !380, metadata !DIExpression()), !dbg !388
  %44 = trunc i64 %25 to i32, !dbg !419
  br label %45, !dbg !434

45:                                               ; preds = %32, %41, %43, %39
  %46 = phi i32 [ %24, %39 ], [ %24, %41 ], [ %24, %43 ], [ %35, %32 ]
  %47 = phi i32 [ %40, %39 ], [ %42, %41 ], [ %44, %43 ], [ %36, %32 ]
  %48 = phi i32 [ %26, %39 ], [ %26, %41 ], [ %26, %43 ], [ %36, %32 ]
  %49 = phi i32 [ 0, %39 ], [ 0, %41 ], [ 1, %43 ], [ 0, %32 ], !dbg !388
  call void @llvm.dbg.value(metadata i32 %49, metadata !379, metadata !DIExpression()), !dbg !388
  %50 = add i32 %48, -1, !dbg !434
  %51 = icmp ugt i32 %50, 249, !dbg !434
  br i1 %51, label %52, label %60, !dbg !434

52:                                               ; preds = %45
  %53 = bitcast %struct.xdp_md* %0 to i8*, !dbg !436
  %54 = getelementptr inbounds i8, i8* %15, i64 8, !dbg !438
  %55 = bitcast i8* %54 to i16*, !dbg !438
  %56 = load i16, i16* %55, align 4, !dbg !438, !tbaa !354
  %57 = zext i16 %56 to i32, !dbg !439
  %58 = sub nuw nsw i32 -50, %57, !dbg !440
  %59 = call i32 inttoptr (i64 44 to i32 (i8*, i32)*)(i8* %53, i32 %58) #3, !dbg !441
  br label %126, !dbg !442

60:                                               ; preds = %45
  %61 = bitcast i32* %3 to i8*, !dbg !443
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %61) #3, !dbg !443
  %62 = urem i32 %46, 2777777, !dbg !444
  call void @llvm.dbg.value(metadata i32 %62, metadata !381, metadata !DIExpression()), !dbg !388
  store i32 %62, i32* %3, align 4, !dbg !445, !tbaa !311
  %63 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @map_kcache to i8*), i8* nonnull %61) #3, !dbg !446
  call void @llvm.dbg.value(metadata i8* %63, metadata !382, metadata !DIExpression()), !dbg !388
  %64 = icmp eq i8* %63, null, !dbg !447
  br i1 %64, label %125, label %65, !dbg !449

65:                                               ; preds = %60
  %66 = bitcast i8* %63 to %struct.bpf_spin_lock*, !dbg !450
  call void inttoptr (i64 93 to void (%struct.bpf_spin_lock*)*)(%struct.bpf_spin_lock* nonnull %66) #3, !dbg !451
  %67 = getelementptr inbounds i8, i8* %63, i64 8, !dbg !452
  %68 = load i8, i8* %67, align 4, !dbg !452, !tbaa !453
  %69 = icmp eq i8 %68, 0, !dbg !456
  br i1 %69, label %92, label %70, !dbg !457

70:                                               ; preds = %65
  %71 = getelementptr inbounds i8, i8* %63, i64 12, !dbg !458
  %72 = bitcast i8* %71 to i32*, !dbg !458
  %73 = load i32, i32* %72, align 4, !dbg !458, !tbaa !459
  %74 = load i32, i32* %22, align 4, !dbg !460, !tbaa !411
  %75 = icmp eq i32 %73, %74, !dbg !461
  br i1 %75, label %76, label %92, !dbg !462

76:                                               ; preds = %70
  call void inttoptr (i64 94 to void (%struct.bpf_spin_lock*)*)(%struct.bpf_spin_lock* nonnull %66) #3, !dbg !463
  call void @llvm.dbg.value(metadata i32 0, metadata !383, metadata !DIExpression()), !dbg !464
  %77 = getelementptr inbounds i8, i8* %19, i64 4, !dbg !465
  %78 = zext i32 %48 to i64, !dbg !469
  br label %79, !dbg !470

79:                                               ; preds = %84, %76
  %80 = phi i64 [ 0, %76 ], [ %87, %84 ]
  call void @llvm.dbg.value(metadata i64 %80, metadata !383, metadata !DIExpression()), !dbg !464
  %81 = getelementptr inbounds i8, i8* %11, i64 %80, !dbg !471
  %82 = getelementptr inbounds i8, i8* %81, i64 1, !dbg !472
  %83 = icmp ugt i8* %82, %7, !dbg !473
  br i1 %83, label %89, label %84, !dbg !474

84:                                               ; preds = %79
  %85 = load i8, i8* %81, align 1, !dbg !475, !tbaa !296
  %86 = getelementptr inbounds i8, i8* %77, i64 %80, !dbg !476
  store i8 %85, i8* %86, align 1, !dbg !477, !tbaa !296
  %87 = add nuw nsw i64 %80, 1, !dbg !478
  call void @llvm.dbg.value(metadata i32 undef, metadata !383, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !464
  %88 = icmp eq i64 %87, %78, !dbg !469
  br i1 %88, label %89, label %79, !dbg !470, !llvm.loop !479

89:                                               ; preds = %79, %84
  %90 = getelementptr inbounds i8, i8* %19, i64 256, !dbg !481
  %91 = bitcast i8* %90 to i32*, !dbg !481
  store i32 %48, i32* %91, align 4, !dbg !482, !tbaa !483
  br label %98, !dbg !484

92:                                               ; preds = %65, %70
  call void inttoptr (i64 94 to void (%struct.bpf_spin_lock*)*)(%struct.bpf_spin_lock* nonnull %66) #3, !dbg !485
  %93 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @map_stats to i8*), i8* nonnull %12) #3, !dbg !486
  call void @llvm.dbg.value(metadata i8* %93, metadata !386, metadata !DIExpression()), !dbg !487
  %94 = icmp eq i8* %93, null, !dbg !488
  br i1 %94, label %125, label %95, !dbg !490

95:                                               ; preds = %92
  call void @llvm.dbg.value(metadata i8* %93, metadata !386, metadata !DIExpression()), !dbg !487
  %96 = getelementptr inbounds i8, i8* %93, i64 20, !dbg !491
  %97 = bitcast i8* %96 to i32*, !dbg !491
  br label %98

98:                                               ; preds = %95, %89
  %99 = phi i32* [ %97, %95 ], [ %18, %89 ]
  %100 = load i32, i32* %99, align 4, !dbg !492, !tbaa !311
  %101 = add i32 %100, 1, !dbg !492
  store i32 %101, i32* %99, align 4, !dbg !492, !tbaa !311
  %102 = icmp eq i32 %49, 0, !dbg !493
  br i1 %102, label %114, label %103, !dbg !495

103:                                              ; preds = %98
  %104 = bitcast %struct.xdp_md* %0 to i8*, !dbg !496
  %105 = getelementptr inbounds i8, i8* %15, i64 8, !dbg !498
  %106 = bitcast i8* %105 to i16*, !dbg !498
  %107 = load i16, i16* %106, align 4, !dbg !498, !tbaa !354
  %108 = zext i16 %107 to i32, !dbg !499
  %109 = sub nuw nsw i32 -50, %108, !dbg !500
  %110 = call i32 inttoptr (i64 44 to i32 (i8*, i32)*)(i8* %104, i32 %109) #3, !dbg !501
  %111 = load i32, i32* %18, align 4, !dbg !502, !tbaa !326
  %112 = icmp eq i32 %111, 0, !dbg !504
  br i1 %112, label %125, label %113, !dbg !505

113:                                              ; preds = %103
  call void inttoptr (i64 12 to void (i8*, i8*, i32)*)(i8* %104, i8* bitcast (%struct.bpf_map_def* @map_progs_xdp to i8*), i32 1) #3, !dbg !506
  br label %125, !dbg !508

114:                                              ; preds = %98
  %115 = add nuw i32 %47, 1, !dbg !509
  call void @llvm.dbg.value(metadata i32 %115, metadata !378, metadata !DIExpression()), !dbg !388
  %116 = getelementptr inbounds i8, i8* %15, i64 8, !dbg !511
  %117 = bitcast i8* %116 to i16*, !dbg !511
  %118 = load i16, i16* %117, align 4, !dbg !512, !tbaa !354
  %119 = trunc i32 %115 to i16, !dbg !512
  %120 = add i16 %118, %119, !dbg !512
  store i16 %120, i16* %117, align 4, !dbg !512, !tbaa !354
  %121 = bitcast %struct.xdp_md* %0 to i8*, !dbg !513
  %122 = call i32 inttoptr (i64 44 to i32 (i8*, i32)*)(i8* %121, i32 %115) #3, !dbg !515
  %123 = icmp eq i32 %122, 0, !dbg !515
  br i1 %123, label %124, label %125, !dbg !516

124:                                              ; preds = %114
  call void inttoptr (i64 12 to void (i8*, i8*, i32)*)(i8* %121, i8* bitcast (%struct.bpf_map_def* @map_progs_xdp to i8*), i32 0) #3, !dbg !517
  br label %125

125:                                              ; preds = %124, %113, %103, %114, %92, %60
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %61) #3, !dbg !518
  br label %126

126:                                              ; preds = %14, %52, %125, %17, %1
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %12) #3, !dbg !518
  ret i32 2, !dbg !518
}

; Function Attrs: nounwind uwtable
define dso_local i32 @xdp_memcached_rx_get_adjust_pkt_main(%struct.xdp_md*) #0 section "xdp_memcached_rx_get_adjust_pkt" !dbg !519 {
  %2 = alloca [6 x i8], align 1
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !521, metadata !DIExpression()), !dbg !545
  %3 = bitcast %struct.xdp_md* %0 to i8*, !dbg !546
  %4 = tail call i32 inttoptr (i64 44 to i32 (i8*, i32)*)(i8* %3, i32 -128) #3, !dbg !548
  %5 = icmp eq i32 %4, 0, !dbg !548
  br i1 %5, label %6, label %42, !dbg !549

6:                                                ; preds = %1
  %7 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !550
  %8 = load i32, i32* %7, align 4, !dbg !550, !tbaa !254
  %9 = zext i32 %8 to i64, !dbg !551
  %10 = inttoptr i64 %9 to i8*, !dbg !552
  call void @llvm.dbg.value(metadata i8* %10, metadata !522, metadata !DIExpression()), !dbg !545
  %11 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !553
  %12 = load i32, i32* %11, align 4, !dbg !553, !tbaa !262
  %13 = zext i32 %12 to i64, !dbg !554
  %14 = inttoptr i64 %13 to i8*, !dbg !555
  call void @llvm.dbg.value(metadata i8* %14, metadata !523, metadata !DIExpression()), !dbg !545
  %15 = inttoptr i64 %13 to %struct.ethhdr*, !dbg !556
  call void @llvm.dbg.value(metadata %struct.ethhdr* %15, metadata !524, metadata !DIExpression()), !dbg !545
  call void @llvm.dbg.value(metadata i8* %14, metadata !525, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !545
  call void @llvm.dbg.value(metadata i8* %14, metadata !526, metadata !DIExpression(DW_OP_plus_uconst, 34, DW_OP_stack_value)), !dbg !545
  call void @llvm.dbg.value(metadata i8* %14, metadata !527, metadata !DIExpression(DW_OP_plus_uconst, 42, DW_OP_stack_value)), !dbg !545
  %16 = getelementptr inbounds i8, i8* %14, i64 50, !dbg !557
  call void @llvm.dbg.value(metadata i8* %16, metadata !539, metadata !DIExpression()), !dbg !545
  call void @llvm.dbg.value(metadata i8* %14, metadata !540, metadata !DIExpression(DW_OP_plus_uconst, 128, DW_OP_stack_value)), !dbg !545
  call void @llvm.dbg.value(metadata i8* %14, metadata !541, metadata !DIExpression(DW_OP_plus_uconst, 170, DW_OP_plus_uconst, 8, DW_OP_stack_value)), !dbg !545
  %17 = icmp ult i8* %16, %10, !dbg !558
  %18 = getelementptr inbounds i8, i8* %14, i64 179, !dbg !560
  %19 = icmp ult i8* %18, %10, !dbg !561
  %20 = and i1 %17, %19, !dbg !562
  call void @llvm.dbg.value(metadata i8* %14, metadata !541, metadata !DIExpression(DW_OP_plus_uconst, 178, DW_OP_stack_value)), !dbg !545
  br i1 %20, label %21, label %42, !dbg !562

21:                                               ; preds = %6
  %22 = getelementptr i8, i8* %14, i64 128, !dbg !563
  call void @llvm.dbg.value(metadata i8* %22, metadata !540, metadata !DIExpression()), !dbg !545
  %23 = getelementptr i8, i8* %14, i64 34, !dbg !564
  call void @llvm.dbg.value(metadata i8* %23, metadata !526, metadata !DIExpression()), !dbg !545
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %14, i8* align 1 %22, i64 50, i1 false), !dbg !565
  %24 = getelementptr inbounds [6 x i8], [6 x i8]* %2, i64 0, i64 0, !dbg !566
  call void @llvm.lifetime.start.p0i8(i64 6, i8* nonnull %24), !dbg !566
  call void @llvm.dbg.declare(metadata [6 x i8]* %2, metadata !542, metadata !DIExpression()), !dbg !567
  %25 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 1, i64 0, !dbg !568
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 %24, i8* nonnull align 1 %25, i64 6, i1 false), !dbg !568
  %26 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %15, i64 0, i32 0, i64 0, !dbg !569
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 1 %25, i8* align 1 %26, i64 6, i1 false), !dbg !569
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %26, i8* nonnull align 1 %24, i64 6, i1 false), !dbg !570
  %27 = getelementptr inbounds i8, i8* %14, i64 26, !dbg !571
  %28 = bitcast i8* %27 to i32*, !dbg !571
  %29 = load i32, i32* %28, align 4, !dbg !571, !tbaa !572
  call void @llvm.dbg.value(metadata i32 %29, metadata !543, metadata !DIExpression()), !dbg !545
  %30 = getelementptr inbounds i8, i8* %14, i64 30, !dbg !573
  %31 = bitcast i8* %30 to i32*, !dbg !573
  %32 = load i32, i32* %31, align 4, !dbg !573, !tbaa !574
  store i32 %32, i32* %28, align 4, !dbg !575, !tbaa !572
  store i32 %29, i32* %31, align 4, !dbg !576, !tbaa !574
  %33 = bitcast i8* %23 to i16*, !dbg !577
  %34 = load i16, i16* %33, align 2, !dbg !577, !tbaa !578
  call void @llvm.dbg.value(metadata i16 %34, metadata !544, metadata !DIExpression()), !dbg !545
  %35 = getelementptr inbounds i8, i8* %14, i64 36, !dbg !580
  %36 = bitcast i8* %35 to i16*, !dbg !580
  %37 = load i16, i16* %36, align 2, !dbg !580, !tbaa !581
  store i16 %37, i16* %33, align 2, !dbg !582, !tbaa !578
  store i16 %34, i16* %36, align 2, !dbg !583, !tbaa !581
  %38 = tail call i32 inttoptr (i64 44 to i32 (i8*, i32)*)(i8* nonnull %3, i32 50) #3, !dbg !584
  %39 = icmp eq i32 %38, 0, !dbg !584
  br i1 %39, label %40, label %41, !dbg !586

40:                                               ; preds = %21
  tail call void inttoptr (i64 12 to void (i8*, i8*, i32)*)(i8* nonnull %3, i8* bitcast (%struct.bpf_map_def* @map_progs_xdp to i8*), i32 2) #3, !dbg !587
  br label %41, !dbg !588

41:                                               ; preds = %21, %40
  call void @llvm.lifetime.end.p0i8(i64 6, i8* nonnull %24), !dbg !589
  br label %42

42:                                               ; preds = %41, %6, %1
  ret i32 2, !dbg !589
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #2

; Function Attrs: nounwind uwtable
define dso_local i32 @xdp_memcached_rx_get_write_pkt_main(%struct.xdp_md*) #0 section "xdp_memcached_rx_get_write_pkt" !dbg !590 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !592, metadata !DIExpression()), !dbg !619
  %4 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !620
  %5 = load i32, i32* %4, align 4, !dbg !620, !tbaa !254
  %6 = zext i32 %5 to i64, !dbg !621
  %7 = inttoptr i64 %6 to i8*, !dbg !622
  call void @llvm.dbg.value(metadata i8* %7, metadata !593, metadata !DIExpression()), !dbg !619
  %8 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !623
  %9 = load i32, i32* %8, align 4, !dbg !623, !tbaa !262
  %10 = zext i32 %9 to i64, !dbg !624
  %11 = inttoptr i64 %10 to i8*, !dbg !625
  call void @llvm.dbg.value(metadata i8* %11, metadata !594, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i8* %11, metadata !595, metadata !DIExpression()), !dbg !619
  %12 = bitcast i32* %2 to i8*, !dbg !626
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %12) #3, !dbg !626
  call void @llvm.dbg.value(metadata i32 0, metadata !596, metadata !DIExpression()), !dbg !619
  store i32 0, i32* %2, align 4, !dbg !627, !tbaa !311
  %13 = icmp ult i8* %11, %7, !dbg !628
  br i1 %13, label %14, label %281, !dbg !630

14:                                               ; preds = %1
  %15 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @map_parsing_context to i8*), i8* nonnull %12) #3, !dbg !631
  call void @llvm.dbg.value(metadata i8* %15, metadata !597, metadata !DIExpression()), !dbg !619
  %16 = icmp eq i8* %15, null, !dbg !632
  br i1 %16, label %281, label %17, !dbg !634

17:                                               ; preds = %14
  %18 = getelementptr inbounds i8, i8* %15, i64 4, !dbg !635
  %19 = bitcast i8* %18 to i32*, !dbg !635
  %20 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon* @map_keys to i8*), i8* nonnull %18) #3, !dbg !636
  call void @llvm.dbg.value(metadata i8* %20, metadata !598, metadata !DIExpression()), !dbg !619
  %21 = icmp eq i8* %20, null, !dbg !637
  br i1 %21, label %281, label %22, !dbg !639

22:                                               ; preds = %17
  call void @llvm.dbg.value(metadata i32 1, metadata !599, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i32 0, metadata !600, metadata !DIExpression()), !dbg !619
  %23 = bitcast i32* %3 to i8*, !dbg !640
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %23) #3, !dbg !640
  %24 = bitcast i8* %20 to i32*, !dbg !641
  %25 = load i32, i32* %24, align 4, !dbg !641, !tbaa !411
  %26 = urem i32 %25, 2777777, !dbg !642
  call void @llvm.dbg.value(metadata i32 %26, metadata !601, metadata !DIExpression()), !dbg !619
  store i32 %26, i32* %3, align 4, !dbg !643, !tbaa !311
  %27 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @map_kcache to i8*), i8* nonnull %23) #3, !dbg !644
  call void @llvm.dbg.value(metadata i8* %27, metadata !602, metadata !DIExpression()), !dbg !619
  %28 = icmp eq i8* %27, null, !dbg !645
  br i1 %28, label %279, label %29, !dbg !647

29:                                               ; preds = %22
  %30 = bitcast i8* %27 to %struct.bpf_spin_lock*, !dbg !648
  call void inttoptr (i64 93 to void (%struct.bpf_spin_lock*)*)(%struct.bpf_spin_lock* nonnull %30) #3, !dbg !649
  %31 = getelementptr inbounds i8, i8* %27, i64 8, !dbg !650
  %32 = load i8, i8* %31, align 4, !dbg !650, !tbaa !453
  %33 = icmp eq i8 %32, 0, !dbg !651
  br i1 %33, label %125, label %34, !dbg !652

34:                                               ; preds = %29
  %35 = load i32, i32* %24, align 4, !dbg !653, !tbaa !411
  %36 = getelementptr inbounds i8, i8* %27, i64 12, !dbg !654
  %37 = bitcast i8* %36 to i32*, !dbg !654
  %38 = load i32, i32* %37, align 4, !dbg !654, !tbaa !459
  %39 = icmp eq i32 %35, %38, !dbg !655
  br i1 %39, label %40, label %125, !dbg !656

40:                                               ; preds = %34
  %41 = getelementptr inbounds i8, i8* %20, i64 256, !dbg !657
  %42 = bitcast i8* %41 to i32*, !dbg !657
  call void @llvm.dbg.value(metadata i32 1, metadata !599, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i32 0, metadata !603, metadata !DIExpression()), !dbg !659
  %43 = load i32, i32* %42, align 4, !dbg !660, !tbaa !483
  %44 = getelementptr inbounds i8, i8* %20, i64 4, !dbg !661
  %45 = getelementptr inbounds i8, i8* %27, i64 20, !dbg !661
  %46 = zext i32 %43 to i64, !dbg !664
  br label %47, !dbg !665

47:                                               ; preds = %59, %40
  %48 = phi i64 [ 0, %40 ], [ %67, %59 ]
  %49 = phi i32 [ 1, %40 ], [ %66, %59 ]
  call void @llvm.dbg.value(metadata i32 %49, metadata !599, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i64 %48, metadata !603, metadata !DIExpression()), !dbg !659
  %50 = icmp eq i64 %48, %46, !dbg !664
  br i1 %50, label %51, label %59, !dbg !666

51:                                               ; preds = %59, %47
  %52 = phi i32 [ %66, %59 ], [ %49, %47 ], !dbg !619
  call void @llvm.dbg.value(metadata i32 %52, metadata !599, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i32 %52, metadata !599, metadata !DIExpression()), !dbg !619
  %53 = icmp eq i32 %52, 0, !dbg !667
  br i1 %53, label %125, label %54, !dbg !668

54:                                               ; preds = %51
  %55 = getelementptr inbounds i8, i8* %27, i64 4, !dbg !669
  %56 = bitcast i8* %55 to i32*, !dbg !669
  call void @llvm.dbg.value(metadata i32 0, metadata !600, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i32 0, metadata !607, metadata !DIExpression()), !dbg !672
  %57 = load i32, i32* %56, align 4, !dbg !673, !tbaa !674
  %58 = zext i32 %57 to i64, !dbg !673
  br label %69, !dbg !675

59:                                               ; preds = %47
  %60 = getelementptr inbounds i8, i8* %44, i64 %48, !dbg !676
  %61 = load i8, i8* %60, align 1, !dbg !676, !tbaa !296
  %62 = add nuw nsw i64 %48, 6, !dbg !677
  %63 = getelementptr inbounds i8, i8* %45, i64 %62, !dbg !678
  %64 = load i8, i8* %63, align 1, !dbg !678, !tbaa !296
  %65 = icmp eq i8 %61, %64, !dbg !679
  %66 = select i1 %65, i32 %49, i32 0, !dbg !680
  %67 = add nuw nsw i64 %48, 1, !dbg !681
  call void @llvm.dbg.value(metadata i32 %66, metadata !599, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i32 undef, metadata !603, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !659
  %68 = icmp eq i64 %67, 250, !dbg !682
  br i1 %68, label %51, label %47, !dbg !665, !llvm.loop !683

69:                                               ; preds = %54, %78
  %70 = phi i64 [ 8, %54 ], [ %85, %78 ]
  %71 = phi i64 [ 0, %54 ], [ %84, %78 ]
  %72 = phi i32 [ 0, %54 ], [ %83, %78 ]
  call void @llvm.dbg.value(metadata i32 %72, metadata !600, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i32 %72, metadata !607, metadata !DIExpression()), !dbg !672
  %73 = icmp ugt i64 %70, %58, !dbg !685
  br i1 %73, label %87, label %74, !dbg !686

74:                                               ; preds = %69
  %75 = getelementptr inbounds i8, i8* %11, i64 %71, !dbg !687
  %76 = getelementptr inbounds i8, i8* %75, i64 8, !dbg !688
  %77 = icmp ugt i8* %76, %7, !dbg !689
  br i1 %77, label %87, label %78, !dbg !690

78:                                               ; preds = %74
  %79 = getelementptr inbounds i8, i8* %45, i64 %71, !dbg !691
  %80 = bitcast i8* %79 to i64*, !dbg !693
  %81 = load i64, i64* %80, align 1, !dbg !693, !tbaa !694
  %82 = bitcast i8* %75 to i64*, !dbg !696
  store i64 %81, i64* %82, align 8, !dbg !697, !tbaa !694
  call void @llvm.dbg.value(metadata i32 %72, metadata !607, metadata !DIExpression(DW_OP_plus_uconst, 7, DW_OP_stack_value)), !dbg !672
  %83 = add nuw nsw i32 %72, 8, !dbg !698
  call void @llvm.dbg.value(metadata i32 %83, metadata !600, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i32 %83, metadata !607, metadata !DIExpression()), !dbg !672
  %84 = zext i32 %83 to i64, !dbg !699
  %85 = add nuw nsw i64 %84, 8, !dbg !700
  %86 = icmp ult i64 %85, 403, !dbg !701
  br i1 %86, label %69, label %87, !dbg !675, !llvm.loop !702

87:                                               ; preds = %74, %69, %78
  %88 = phi i32 [ %72, %74 ], [ %72, %69 ], [ %83, %78 ], !dbg !704
  call void @llvm.dbg.value(metadata i32 %88, metadata !607, metadata !DIExpression()), !dbg !672
  call void @llvm.dbg.value(metadata i32 %88, metadata !607, metadata !DIExpression()), !dbg !672
  call void @llvm.dbg.value(metadata i32 %88, metadata !607, metadata !DIExpression()), !dbg !672
  call void @llvm.dbg.value(metadata i32 %88, metadata !600, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i32 %88, metadata !600, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i32 %88, metadata !600, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i32 %88, metadata !600, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i32 %88, metadata !607, metadata !DIExpression()), !dbg !672
  %89 = icmp ult i32 %88, 403, !dbg !705
  br i1 %89, label %90, label %116, !dbg !708

90:                                               ; preds = %87
  %91 = getelementptr inbounds i8, i8* %11, i64 1, !dbg !709
  %92 = zext i32 %88 to i64, !dbg !708
  call void @llvm.dbg.value(metadata i32 %88, metadata !600, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i64 %92, metadata !607, metadata !DIExpression()), !dbg !672
  %93 = icmp uge i32 %88, %57, !dbg !710
  %94 = getelementptr inbounds i8, i8* %91, i64 %92, !dbg !711
  %95 = icmp ugt i8* %94, %7, !dbg !712
  %96 = or i1 %93, %95, !dbg !713
  br i1 %96, label %113, label %97, !dbg !713

97:                                               ; preds = %90, %106
  %98 = phi i32 [ %103, %106 ], [ %88, %90 ]
  %99 = phi i64 [ %104, %106 ], [ %92, %90 ]
  call void @llvm.dbg.value(metadata i32 %98, metadata !600, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i64 %99, metadata !607, metadata !DIExpression()), !dbg !672
  %100 = getelementptr inbounds i8, i8* %45, i64 %99, !dbg !714
  %101 = load i8, i8* %100, align 1, !dbg !714, !tbaa !296
  %102 = getelementptr inbounds i8, i8* %11, i64 %99, !dbg !716
  store i8 %101, i8* %102, align 1, !dbg !717, !tbaa !296
  %103 = add i32 %98, 1, !dbg !718
  %104 = add nuw nsw i64 %99, 1, !dbg !719
  call void @llvm.dbg.value(metadata i32 undef, metadata !607, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !672
  %105 = icmp eq i64 %104, 403, !dbg !705
  br i1 %105, label %113, label %106, !dbg !708, !llvm.loop !720

106:                                              ; preds = %97
  %107 = load i32, i32* %56, align 4, !dbg !723, !tbaa !674
  call void @llvm.dbg.value(metadata i32 %103, metadata !600, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i64 %104, metadata !607, metadata !DIExpression()), !dbg !672
  %108 = zext i32 %107 to i64, !dbg !710
  %109 = icmp uge i64 %104, %108, !dbg !710
  %110 = getelementptr inbounds i8, i8* %91, i64 %104, !dbg !711
  %111 = icmp ugt i8* %110, %7, !dbg !712
  %112 = or i1 %109, %111, !dbg !713
  br i1 %112, label %113, label %97, !dbg !713

113:                                              ; preds = %97, %106, %90
  %114 = phi i32 [ %88, %90 ], [ %103, %106 ], [ %103, %97 ]
  %115 = load i8, i8* %31, align 4, !dbg !724, !tbaa !453
  br label %116, !dbg !724

116:                                              ; preds = %113, %87
  %117 = phi i8 [ %32, %87 ], [ %115, %113 ], !dbg !724
  %118 = phi i32 [ %88, %87 ], [ %114, %113 ], !dbg !619
  call void @llvm.dbg.value(metadata i32 %118, metadata !600, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i32 %118, metadata !600, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i32 %118, metadata !600, metadata !DIExpression()), !dbg !619
  %119 = icmp slt i8 %117, 17, !dbg !726
  br i1 %119, label %120, label %122, !dbg !727

120:                                              ; preds = %116
  %121 = add nsw i8 %117, 1, !dbg !728
  store i8 %121, i8* %31, align 4, !dbg !728, !tbaa !453
  br label %122, !dbg !730

122:                                              ; preds = %120, %116
  %123 = getelementptr inbounds i8, i8* %27, i64 16, !dbg !731
  %124 = bitcast i8* %123 to i32*, !dbg !731
  store i32 0, i32* %124, align 4, !dbg !732, !tbaa !733
  br label %125, !dbg !734

125:                                              ; preds = %51, %29, %122, %34
  %126 = phi i32 [ %118, %122 ], [ 0, %51 ], [ 0, %34 ], [ 0, %29 ], !dbg !735
  %127 = phi i32 [ %52, %122 ], [ 0, %51 ], [ 1, %34 ], [ 1, %29 ], !dbg !736
  call void @llvm.dbg.value(metadata i32 %127, metadata !599, metadata !DIExpression()), !dbg !619
  call void @llvm.dbg.value(metadata i32 %126, metadata !600, metadata !DIExpression()), !dbg !619
  call void inttoptr (i64 94 to void (%struct.bpf_spin_lock*)*)(%struct.bpf_spin_lock* nonnull %30) #3, !dbg !737
  %128 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @map_stats to i8*), i8* nonnull %12) #3, !dbg !738
  call void @llvm.dbg.value(metadata i8* %128, metadata !610, metadata !DIExpression()), !dbg !619
  %129 = icmp eq i8* %128, null, !dbg !739
  br i1 %129, label %279, label %130, !dbg !741

130:                                              ; preds = %125
  %131 = icmp eq i32 %127, 0, !dbg !742
  %132 = getelementptr inbounds i8, i8* %128, i64 20, !dbg !744
  %133 = bitcast i8* %132 to i32*, !dbg !744
  %134 = getelementptr inbounds i8, i8* %128, i64 16, !dbg !744
  %135 = bitcast i8* %134 to i32*, !dbg !744
  %136 = select i1 %131, i32* %133, i32* %135, !dbg !744
  %137 = select i1 %131, i32* %133, i32* %135, !dbg !744
  %138 = load i32, i32* %136, align 4, !dbg !745, !tbaa !311
  %139 = add i32 %138, 1, !dbg !745
  store i32 %139, i32* %137, align 4, !dbg !745, !tbaa !311
  %140 = load i32, i32* %19, align 4, !dbg !746, !tbaa !330
  %141 = add i32 %140, 1, !dbg !746
  store i32 %141, i32* %19, align 4, !dbg !746, !tbaa !330
  %142 = bitcast i8* %15 to i32*, !dbg !747
  %143 = load i32, i32* %142, align 4, !dbg !747, !tbaa !326
  %144 = icmp eq i32 %141, %143, !dbg !748
  br i1 %144, label %145, label %267, !dbg !749

145:                                              ; preds = %130
  %146 = getelementptr inbounds i8, i8* %15, i64 10, !dbg !750
  %147 = bitcast i8* %146 to i16*, !dbg !750
  %148 = load i16, i16* %147, align 2, !dbg !750, !tbaa !333
  %149 = icmp ne i16 %148, 0, !dbg !751
  %150 = icmp ne i32 %126, 0, !dbg !752
  %151 = or i1 %150, %149, !dbg !753
  br i1 %151, label %152, label %260, !dbg !753

152:                                              ; preds = %145
  %153 = zext i32 %126 to i64, !dbg !754
  %154 = getelementptr inbounds i8, i8* %11, i64 %153, !dbg !754
  %155 = getelementptr inbounds i8, i8* %154, i64 5, !dbg !755
  %156 = icmp ugt i8* %155, %7, !dbg !756
  br i1 %156, label %279, label %157, !dbg !757

157:                                              ; preds = %152
  %158 = add i32 %126, 1, !dbg !758
  call void @llvm.dbg.value(metadata i32 %158, metadata !600, metadata !DIExpression()), !dbg !619
  store i8 69, i8* %154, align 1, !dbg !759, !tbaa !296
  %159 = add i32 %126, 2, !dbg !760
  call void @llvm.dbg.value(metadata i32 %159, metadata !600, metadata !DIExpression()), !dbg !619
  %160 = zext i32 %158 to i64, !dbg !761
  %161 = getelementptr inbounds i8, i8* %11, i64 %160, !dbg !761
  store i8 78, i8* %161, align 1, !dbg !762, !tbaa !296
  %162 = add i32 %126, 3, !dbg !763
  call void @llvm.dbg.value(metadata i32 %162, metadata !600, metadata !DIExpression()), !dbg !619
  %163 = zext i32 %159 to i64, !dbg !764
  %164 = getelementptr inbounds i8, i8* %11, i64 %163, !dbg !764
  store i8 68, i8* %164, align 1, !dbg !765, !tbaa !296
  %165 = add i32 %126, 4, !dbg !766
  call void @llvm.dbg.value(metadata i32 %165, metadata !600, metadata !DIExpression()), !dbg !619
  %166 = zext i32 %162 to i64, !dbg !767
  %167 = getelementptr inbounds i8, i8* %11, i64 %166, !dbg !767
  store i8 13, i8* %167, align 1, !dbg !768, !tbaa !296
  %168 = add i32 %126, 5, !dbg !769
  call void @llvm.dbg.value(metadata i32 %168, metadata !600, metadata !DIExpression()), !dbg !619
  %169 = zext i32 %165 to i64, !dbg !770
  %170 = getelementptr inbounds i8, i8* %11, i64 %169, !dbg !770
  store i8 10, i8* %170, align 1, !dbg !771, !tbaa !296
  %171 = bitcast %struct.xdp_md* %0 to i8*, !dbg !772
  %172 = load i16, i16* %147, align 2, !dbg !774, !tbaa !333
  %173 = zext i16 %172 to i32, !dbg !775
  %174 = sub nuw nsw i32 -50, %173, !dbg !776
  %175 = call i32 inttoptr (i64 44 to i32 (i8*, i32)*)(i8* %171, i32 %174) #3, !dbg !777
  %176 = icmp eq i32 %175, 0, !dbg !777
  br i1 %176, label %177, label %279, !dbg !778

177:                                              ; preds = %157
  %178 = load i32, i32* %4, align 4, !dbg !779, !tbaa !254
  %179 = zext i32 %178 to i64, !dbg !780
  call void @llvm.dbg.value(metadata i64 %179, metadata !611, metadata !DIExpression()), !dbg !781
  %180 = load i32, i32* %8, align 4, !dbg !782, !tbaa !262
  %181 = zext i32 %180 to i64, !dbg !783
  %182 = inttoptr i64 %181 to i8*, !dbg !784
  call void @llvm.dbg.value(metadata i8* %182, metadata !616, metadata !DIExpression()), !dbg !781
  %183 = getelementptr i8, i8* %182, i64 14, !dbg !785
  call void @llvm.dbg.value(metadata i8* %183, metadata !617, metadata !DIExpression()), !dbg !781
  call void @llvm.dbg.value(metadata i8* %182, metadata !618, metadata !DIExpression(DW_OP_plus_uconst, 34, DW_OP_stack_value)), !dbg !781
  call void @llvm.dbg.value(metadata i8* %182, metadata !595, metadata !DIExpression(DW_OP_plus_uconst, 50, DW_OP_stack_value)), !dbg !619
  %184 = getelementptr inbounds i8, i8* %182, i64 42, !dbg !786
  %185 = bitcast i8* %184 to %struct.udphdr*, !dbg !786
  %186 = inttoptr i64 %179 to %struct.udphdr*, !dbg !788
  %187 = icmp ugt %struct.udphdr* %185, %186, !dbg !789
  br i1 %187, label %279, label %188, !dbg !790

188:                                              ; preds = %177
  call void @llvm.dbg.value(metadata i8* %183, metadata !617, metadata !DIExpression()), !dbg !781
  %189 = getelementptr i8, i8* %182, i64 50, !dbg !791
  call void @llvm.dbg.value(metadata i8* %189, metadata !595, metadata !DIExpression()), !dbg !619
  %190 = getelementptr i8, i8* %182, i64 34, !dbg !792
  call void @llvm.dbg.value(metadata i8* %190, metadata !618, metadata !DIExpression()), !dbg !781
  %191 = load i16, i16* %147, align 2, !dbg !793, !tbaa !333
  %192 = zext i16 %191 to i64, !dbg !793
  %193 = getelementptr inbounds i8, i8* %189, i64 %192, !dbg !793
  %194 = zext i32 %168 to i64, !dbg !793
  %195 = getelementptr inbounds i8, i8* %193, i64 %194, !dbg !793
  %196 = ptrtoint i8* %195 to i64, !dbg !793
  %197 = ptrtoint i8* %183 to i64, !dbg !793
  %198 = sub i64 %196, %197, !dbg !793
  %199 = trunc i64 %198 to i16, !dbg !793
  %200 = call i16 @llvm.bswap.i16(i16 %199), !dbg !793
  %201 = getelementptr inbounds i8, i8* %182, i64 16, !dbg !794
  %202 = bitcast i8* %201 to i16*, !dbg !794
  store i16 %200, i16* %202, align 2, !dbg !795, !tbaa !796
  call void @llvm.dbg.value(metadata i8* %183, metadata !797, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 0, metadata !802, metadata !DIExpression()), !dbg !806
  %203 = bitcast i8* %183 to i16*, !dbg !808
  call void @llvm.dbg.value(metadata i16* %203, metadata !803, metadata !DIExpression()), !dbg !806
  %204 = getelementptr inbounds i8, i8* %182, i64 24, !dbg !809
  %205 = bitcast i8* %204 to i16*, !dbg !809
  call void @llvm.dbg.value(metadata i32 0, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %203, metadata !803, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 0, metadata !802, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 0, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %203, metadata !803, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 0, metadata !802, metadata !DIExpression()), !dbg !806
  %206 = load i16, i16* %203, align 2, !dbg !811, !tbaa !289
  %207 = zext i16 %206 to i32, !dbg !811
  call void @llvm.dbg.value(metadata i32 1, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %202, metadata !803, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 %207, metadata !802, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 1, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %202, metadata !803, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 %207, metadata !802, metadata !DIExpression()), !dbg !806
  %208 = getelementptr inbounds i8, i8* %182, i64 18, !dbg !813
  %209 = bitcast i8* %208 to i16*, !dbg !813
  %210 = zext i16 %200 to i32, !dbg !811
  %211 = add nuw nsw i32 %210, %207, !dbg !814
  call void @llvm.dbg.value(metadata i32 2, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %209, metadata !803, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 %211, metadata !802, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 2, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %209, metadata !803, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 %211, metadata !802, metadata !DIExpression()), !dbg !806
  %212 = getelementptr inbounds i8, i8* %182, i64 20, !dbg !813
  %213 = bitcast i8* %212 to i16*, !dbg !813
  %214 = load i16, i16* %209, align 2, !dbg !811, !tbaa !289
  %215 = zext i16 %214 to i32, !dbg !811
  %216 = add nuw nsw i32 %211, %215, !dbg !814
  call void @llvm.dbg.value(metadata i32 3, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %213, metadata !803, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 %216, metadata !802, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 3, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %213, metadata !803, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 %216, metadata !802, metadata !DIExpression()), !dbg !806
  %217 = getelementptr inbounds i8, i8* %182, i64 22, !dbg !813
  %218 = bitcast i8* %217 to i16*, !dbg !813
  %219 = load i16, i16* %213, align 2, !dbg !811, !tbaa !289
  %220 = zext i16 %219 to i32, !dbg !811
  %221 = add nuw nsw i32 %216, %220, !dbg !814
  call void @llvm.dbg.value(metadata i32 4, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %218, metadata !803, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 %221, metadata !802, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 4, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %218, metadata !803, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 %221, metadata !802, metadata !DIExpression()), !dbg !806
  %222 = load i16, i16* %218, align 2, !dbg !811, !tbaa !289
  %223 = zext i16 %222 to i32, !dbg !811
  %224 = add nuw nsw i32 %221, %223, !dbg !814
  call void @llvm.dbg.value(metadata i32 5, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %202, metadata !803, metadata !DIExpression(DW_OP_plus_uconst, 8, DW_OP_stack_value)), !dbg !806
  call void @llvm.dbg.value(metadata i32 %224, metadata !802, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 5, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %202, metadata !803, metadata !DIExpression(DW_OP_plus_uconst, 8, DW_OP_stack_value)), !dbg !806
  call void @llvm.dbg.value(metadata i32 %224, metadata !802, metadata !DIExpression()), !dbg !806
  %225 = getelementptr inbounds i8, i8* %182, i64 26, !dbg !813
  %226 = bitcast i8* %225 to i16*, !dbg !813
  call void @llvm.dbg.value(metadata i32 6, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %226, metadata !803, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 %224, metadata !802, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 6, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %226, metadata !803, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 %224, metadata !802, metadata !DIExpression()), !dbg !806
  %227 = getelementptr inbounds i8, i8* %182, i64 28, !dbg !813
  %228 = bitcast i8* %227 to i16*, !dbg !813
  %229 = load i16, i16* %226, align 2, !dbg !811, !tbaa !289
  %230 = zext i16 %229 to i32, !dbg !811
  %231 = add nuw nsw i32 %224, %230, !dbg !814
  call void @llvm.dbg.value(metadata i32 7, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %228, metadata !803, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 %231, metadata !802, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 7, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %228, metadata !803, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 %231, metadata !802, metadata !DIExpression()), !dbg !806
  %232 = getelementptr inbounds i8, i8* %182, i64 30, !dbg !813
  %233 = bitcast i8* %232 to i16*, !dbg !813
  %234 = load i16, i16* %228, align 2, !dbg !811, !tbaa !289
  %235 = zext i16 %234 to i32, !dbg !811
  %236 = add nuw nsw i32 %231, %235, !dbg !814
  call void @llvm.dbg.value(metadata i32 8, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %233, metadata !803, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 %236, metadata !802, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 8, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %233, metadata !803, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 %236, metadata !802, metadata !DIExpression()), !dbg !806
  %237 = getelementptr inbounds i8, i8* %182, i64 32, !dbg !813
  %238 = bitcast i8* %237 to i16*, !dbg !813
  %239 = load i16, i16* %233, align 2, !dbg !811, !tbaa !289
  %240 = zext i16 %239 to i32, !dbg !811
  %241 = add nuw nsw i32 %236, %240, !dbg !814
  call void @llvm.dbg.value(metadata i32 9, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %238, metadata !803, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 %241, metadata !802, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 9, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i16* %238, metadata !803, metadata !DIExpression()), !dbg !806
  call void @llvm.dbg.value(metadata i32 %241, metadata !802, metadata !DIExpression()), !dbg !806
  %242 = load i16, i16* %238, align 2, !dbg !811, !tbaa !289
  %243 = zext i16 %242 to i32, !dbg !811
  %244 = add nuw nsw i32 %241, %243, !dbg !814
  call void @llvm.dbg.value(metadata i32 10, metadata !804, metadata !DIExpression()), !dbg !810
  call void @llvm.dbg.value(metadata i32 %244, metadata !802, metadata !DIExpression()), !dbg !806
  %245 = lshr i32 %244, 16, !dbg !815
  %246 = add nuw nsw i32 %245, %244, !dbg !816
  %247 = trunc i32 %246 to i16, !dbg !817
  %248 = xor i16 %247, -1, !dbg !817
  store i16 %248, i16* %205, align 2, !dbg !818, !tbaa !819
  %249 = getelementptr inbounds i8, i8* %182, i64 40, !dbg !820
  %250 = bitcast i8* %249 to i16*, !dbg !820
  store i16 0, i16* %250, align 2, !dbg !821, !tbaa !822
  %251 = ptrtoint i8* %190 to i64, !dbg !823
  %252 = sub i64 %196, %251, !dbg !823
  %253 = trunc i64 %252 to i16, !dbg !823
  %254 = call i16 @llvm.bswap.i16(i16 %253), !dbg !823
  %255 = getelementptr inbounds i8, i8* %182, i64 38, !dbg !824
  %256 = bitcast i8* %255 to i16*, !dbg !824
  store i16 %254, i16* %256, align 2, !dbg !825, !tbaa !826
  %257 = trunc i64 %196 to i32, !dbg !827
  %258 = sub i32 %257, %178, !dbg !828
  %259 = call i32 inttoptr (i64 65 to i32 (i8*, i32)*)(i8* nonnull %171, i32 %258) #3, !dbg !829
  br label %279, !dbg !830

260:                                              ; preds = %145
  %261 = getelementptr inbounds i8, i8* %128, i64 12, !dbg !831
  %262 = bitcast i8* %261 to i32*, !dbg !831
  %263 = load i32, i32* %262, align 4, !dbg !834, !tbaa !835
  %264 = add i32 %263, %141, !dbg !834
  store i32 %264, i32* %262, align 4, !dbg !834, !tbaa !835
  %265 = bitcast %struct.xdp_md* %0 to i8*, !dbg !836
  %266 = call i32 inttoptr (i64 44 to i32 (i8*, i32)*)(i8* %265, i32 78) #3, !dbg !837
  br label %279, !dbg !838

267:                                              ; preds = %130
  %268 = icmp ult i32 %141, 31, !dbg !839
  br i1 %268, label %269, label %279, !dbg !841

269:                                              ; preds = %267
  %270 = getelementptr inbounds i8, i8* %15, i64 10, !dbg !842
  %271 = bitcast i8* %270 to i16*, !dbg !842
  %272 = load i16, i16* %271, align 2, !dbg !844, !tbaa !333
  %273 = trunc i32 %126 to i16, !dbg !844
  %274 = add i16 %272, %273, !dbg !844
  store i16 %274, i16* %271, align 2, !dbg !844, !tbaa !333
  %275 = bitcast %struct.xdp_md* %0 to i8*, !dbg !845
  %276 = call i32 inttoptr (i64 44 to i32 (i8*, i32)*)(i8* %275, i32 %126) #3, !dbg !847
  %277 = icmp eq i32 %276, 0, !dbg !847
  br i1 %277, label %278, label %279, !dbg !848

278:                                              ; preds = %269
  call void inttoptr (i64 12 to void (i8*, i8*, i32)*)(i8* %275, i8* bitcast (%struct.bpf_map_def* @map_progs_xdp to i8*), i32 2) #3, !dbg !849
  br label %279, !dbg !850

279:                                              ; preds = %260, %125, %157, %177, %188, %269, %152, %278, %267, %22
  %280 = phi i32 [ 1, %22 ], [ 2, %260 ], [ 2, %125 ], [ 1, %157 ], [ 3, %188 ], [ 2, %177 ], [ 1, %269 ], [ 1, %152 ], [ 1, %278 ], [ 1, %267 ], !dbg !619
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %23) #3, !dbg !851
  br label %281

281:                                              ; preds = %14, %17, %279, %1
  %282 = phi i32 [ 2, %1 ], [ 2, %14 ], [ %280, %279 ], [ 2, %17 ], !dbg !619
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %12) #3, !dbg !851
  ret i32 %282, !dbg !851
}

; Function Attrs: nounwind uwtable
define dso_local i32 @xdp_memcached_rx_set_parse_main(%struct.xdp_md* nocapture readonly) #0 section "xdp_memcached_rx_set_parse" !dbg !852 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca [72 x i8], align 16
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !854, metadata !DIExpression()), !dbg !885
  %5 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !886
  %6 = load i32, i32* %5, align 4, !dbg !886, !tbaa !254
  %7 = zext i32 %6 to i64, !dbg !887
  %8 = inttoptr i64 %7 to i8*, !dbg !888
  call void @llvm.dbg.value(metadata i8* %8, metadata !855, metadata !DIExpression()), !dbg !885
  %9 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !889
  %10 = load i32, i32* %9, align 4, !dbg !889, !tbaa !262
  %11 = zext i32 %10 to i64, !dbg !890
  %12 = inttoptr i64 %11 to i8*, !dbg !891
  call void @llvm.dbg.value(metadata i8* %12, metadata !856, metadata !DIExpression()), !dbg !885
  call void @llvm.dbg.value(metadata i8* %12, metadata !857, metadata !DIExpression()), !dbg !885
  call void @llvm.dbg.value(metadata i8* %12, metadata !858, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !885
  call void @llvm.dbg.value(metadata i8* %12, metadata !859, metadata !DIExpression(DW_OP_plus_uconst, 34, DW_OP_stack_value)), !dbg !885
  %13 = getelementptr inbounds i8, i8* %12, i64 54, !dbg !892
  call void @llvm.dbg.value(metadata i8* %13, metadata !860, metadata !DIExpression()), !dbg !885
  %14 = bitcast i32* %2 to i8*, !dbg !893
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %14) #3, !dbg !893
  call void @llvm.dbg.value(metadata i32 0, metadata !861, metadata !DIExpression()), !dbg !885
  store i32 0, i32* %2, align 4, !dbg !894, !tbaa !311
  %15 = icmp ult i8* %13, %8, !dbg !895
  br i1 %15, label %16, label %113, !dbg !897

16:                                               ; preds = %1
  %17 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @map_stats to i8*), i8* nonnull %14) #3, !dbg !898
  call void @llvm.dbg.value(metadata i8* %17, metadata !862, metadata !DIExpression()), !dbg !885
  %18 = icmp eq i8* %17, null, !dbg !899
  br i1 %18, label %113, label %19, !dbg !901

19:                                               ; preds = %16
  call void @llvm.dbg.value(metadata i32 0, metadata !866, metadata !DIExpression()), !dbg !902
  call void @llvm.dbg.value(metadata i32 0, metadata !865, metadata !DIExpression()), !dbg !885
  call void @llvm.dbg.value(metadata i32 0, metadata !864, metadata !DIExpression()), !dbg !885
  call void @llvm.dbg.value(metadata i32 undef, metadata !863, metadata !DIExpression()), !dbg !885
  %20 = getelementptr inbounds i8, i8* %17, i64 4, !dbg !903
  %21 = bitcast i8* %20 to i32*, !dbg !903
  %22 = bitcast i32* %3 to i8*, !dbg !905
  %23 = getelementptr inbounds i8, i8* %17, i64 28, !dbg !906
  %24 = bitcast i8* %23 to i32*, !dbg !906
  br label %25, !dbg !909

25:                                               ; preds = %19, %96
  %26 = phi i32 [ 0, %19 ], [ %101, %96 ]
  %27 = phi i32 [ 0, %19 ], [ %99, %96 ]
  %28 = phi i32 [ 0, %19 ], [ %98, %96 ]
  %29 = phi i32 [ undef, %19 ], [ %97, %96 ]
  call void @llvm.dbg.value(metadata i32 %26, metadata !866, metadata !DIExpression()), !dbg !902
  call void @llvm.dbg.value(metadata i32 %27, metadata !865, metadata !DIExpression()), !dbg !885
  call void @llvm.dbg.value(metadata i32 %28, metadata !864, metadata !DIExpression()), !dbg !885
  call void @llvm.dbg.value(metadata i32 %29, metadata !863, metadata !DIExpression()), !dbg !885
  %30 = zext i32 %26 to i64, !dbg !910
  %31 = getelementptr inbounds i8, i8* %13, i64 %30, !dbg !910
  %32 = getelementptr inbounds i8, i8* %31, i64 1, !dbg !911
  %33 = icmp ugt i8* %32, %8, !dbg !912
  br i1 %33, label %104, label %34, !dbg !913

34:                                               ; preds = %25
  %35 = icmp eq i32 %28, 0, !dbg !914
  br i1 %35, label %36, label %58, !dbg !915

36:                                               ; preds = %34
  %37 = load i8, i8* %31, align 1, !dbg !916, !tbaa !296
  %38 = icmp ne i8 %37, 115, !dbg !917
  %39 = getelementptr inbounds i8, i8* %31, i64 3, !dbg !918
  %40 = icmp ugt i8* %39, %8, !dbg !919
  %41 = or i1 %40, %38, !dbg !920
  br i1 %41, label %69, label %42, !dbg !920

42:                                               ; preds = %36
  %43 = add nuw nsw i32 %26, 1, !dbg !921
  %44 = zext i32 %43 to i64, !dbg !922
  %45 = getelementptr inbounds i8, i8* %13, i64 %44, !dbg !922
  %46 = load i8, i8* %45, align 1, !dbg !922, !tbaa !296
  %47 = icmp eq i8 %46, 101, !dbg !923
  br i1 %47, label %48, label %69, !dbg !924

48:                                               ; preds = %42
  %49 = add nuw nsw i32 %26, 2, !dbg !925
  %50 = zext i32 %49 to i64, !dbg !926
  %51 = getelementptr inbounds i8, i8* %13, i64 %50, !dbg !926
  %52 = load i8, i8* %51, align 1, !dbg !926, !tbaa !296
  %53 = icmp eq i8 %52, 116, !dbg !927
  br i1 %53, label %54, label %69, !dbg !928

54:                                               ; preds = %48
  call void @llvm.dbg.value(metadata i32 1, metadata !864, metadata !DIExpression()), !dbg !885
  %55 = add nuw nsw i32 %26, 3, !dbg !929
  call void @llvm.dbg.value(metadata i32 %55, metadata !866, metadata !DIExpression()), !dbg !902
  %56 = load i32, i32* %21, align 4, !dbg !930, !tbaa !931
  %57 = add i32 %56, 1, !dbg !930
  store i32 %57, i32* %21, align 4, !dbg !930, !tbaa !931
  br label %96, !dbg !932

58:                                               ; preds = %34
  %59 = icmp eq i32 %27, 0, !dbg !933
  %60 = icmp eq i32 %28, 1, !dbg !934
  %61 = and i1 %60, %59, !dbg !935
  br i1 %61, label %62, label %69, !dbg !935

62:                                               ; preds = %58
  %63 = load i8, i8* %31, align 1, !dbg !936, !tbaa !296
  switch i8 %63, label %65 [
    i8 32, label %64
    i8 13, label %96
  ], !dbg !937

64:                                               ; preds = %62
  br label %96, !dbg !938

65:                                               ; preds = %62
  %66 = sext i8 %63 to i32, !dbg !936
  call void @llvm.dbg.value(metadata i32 -2128831035, metadata !863, metadata !DIExpression()), !dbg !885
  %67 = xor i32 %66, -2128831035, !dbg !939
  call void @llvm.dbg.value(metadata i32 %67, metadata !863, metadata !DIExpression()), !dbg !885
  %68 = mul i32 %67, 16777619, !dbg !943
  call void @llvm.dbg.value(metadata i32 %68, metadata !863, metadata !DIExpression()), !dbg !885
  call void @llvm.dbg.value(metadata i32 1, metadata !865, metadata !DIExpression()), !dbg !885
  br label %96

69:                                               ; preds = %42, %48, %36, %58
  %70 = icmp eq i32 %27, 1, !dbg !944
  br i1 %70, label %71, label %96, !dbg !938

71:                                               ; preds = %69
  %72 = load i8, i8* %31, align 1, !dbg !945, !tbaa !296
  %73 = icmp eq i8 %72, 32, !dbg !946
  br i1 %73, label %74, label %92, !dbg !947

74:                                               ; preds = %71
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %22) #3, !dbg !948
  %75 = urem i32 %29, 2777777, !dbg !949
  call void @llvm.dbg.value(metadata i32 %75, metadata !868, metadata !DIExpression()), !dbg !905
  store i32 %75, i32* %3, align 4, !dbg !950, !tbaa !311
  %76 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @map_kcache to i8*), i8* nonnull %22) #3, !dbg !951
  call void @llvm.dbg.value(metadata i8* %76, metadata !877, metadata !DIExpression()), !dbg !905
  %77 = icmp eq i8* %76, null, !dbg !952
  br i1 %77, label %103, label %78, !dbg !954

78:                                               ; preds = %74
  %79 = bitcast i8* %76 to %struct.bpf_spin_lock*, !dbg !955
  call void inttoptr (i64 93 to void (%struct.bpf_spin_lock*)*)(%struct.bpf_spin_lock* nonnull %79) #3, !dbg !956
  %80 = getelementptr inbounds i8, i8* %76, i64 8, !dbg !957
  %81 = load i8, i8* %80, align 4, !dbg !957, !tbaa !453
  %82 = icmp eq i8 %81, 0, !dbg !958
  br i1 %82, label %91, label %83, !dbg !959

83:                                               ; preds = %78
  %84 = getelementptr inbounds i8, i8* %76, i64 12, !dbg !960
  %85 = bitcast i8* %84 to i32*, !dbg !960
  %86 = load i32, i32* %85, align 4, !dbg !960, !tbaa !459
  %87 = icmp eq i32 %86, %29, !dbg !961
  br i1 %87, label %88, label %91, !dbg !962

88:                                               ; preds = %83
  store i8 0, i8* %80, align 4, !dbg !963, !tbaa !453
  %89 = load i32, i32* %24, align 4, !dbg !964, !tbaa !965
  %90 = add i32 %89, 1, !dbg !964
  store i32 %90, i32* %24, align 4, !dbg !964, !tbaa !965
  br label %91, !dbg !966

91:                                               ; preds = %83, %88, %78
  call void inttoptr (i64 94 to void (%struct.bpf_spin_lock*)*)(%struct.bpf_spin_lock* nonnull %79) #3, !dbg !967
  call void @llvm.dbg.value(metadata i32 0, metadata !864, metadata !DIExpression()), !dbg !885
  call void @llvm.dbg.value(metadata i32 0, metadata !865, metadata !DIExpression()), !dbg !885
  call void @llvm.dbg.value(metadata i32 1, metadata !865, metadata !DIExpression()), !dbg !885
  call void @llvm.dbg.value(metadata i32 undef, metadata !864, metadata !DIExpression()), !dbg !885
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %22) #3, !dbg !968
  br label %96

92:                                               ; preds = %71
  %93 = sext i8 %72 to i32, !dbg !945
  %94 = xor i32 %29, %93, !dbg !969
  call void @llvm.dbg.value(metadata i32 %94, metadata !863, metadata !DIExpression()), !dbg !885
  %95 = mul i32 %94, 16777619, !dbg !971
  call void @llvm.dbg.value(metadata i32 %95, metadata !863, metadata !DIExpression()), !dbg !885
  br label %96

96:                                               ; preds = %91, %64, %62, %54, %69, %92, %65
  %97 = phi i32 [ %29, %54 ], [ %68, %65 ], [ %95, %92 ], [ %29, %69 ], [ %29, %62 ], [ %29, %64 ], [ %29, %91 ]
  %98 = phi i32 [ 1, %54 ], [ 1, %65 ], [ %28, %92 ], [ %28, %69 ], [ 0, %62 ], [ 1, %64 ], [ 0, %91 ], !dbg !885
  %99 = phi i32 [ %27, %54 ], [ 1, %65 ], [ 1, %92 ], [ %27, %69 ], [ 0, %62 ], [ 0, %64 ], [ 0, %91 ], !dbg !885
  %100 = phi i32 [ %55, %54 ], [ %26, %65 ], [ %26, %92 ], [ %26, %69 ], [ %26, %62 ], [ %26, %64 ], [ %26, %91 ], !dbg !902
  call void @llvm.dbg.value(metadata i32 %100, metadata !866, metadata !DIExpression()), !dbg !902
  %101 = add nuw nsw i32 %100, 1, !dbg !972
  call void @llvm.dbg.value(metadata i32 %101, metadata !866, metadata !DIExpression()), !dbg !902
  call void @llvm.dbg.value(metadata i32 %99, metadata !865, metadata !DIExpression()), !dbg !885
  call void @llvm.dbg.value(metadata i32 %98, metadata !864, metadata !DIExpression()), !dbg !885
  call void @llvm.dbg.value(metadata i32 %97, metadata !863, metadata !DIExpression()), !dbg !885
  %102 = icmp ult i32 %101, 1500, !dbg !973
  br i1 %102, label %25, label %104, !dbg !909, !llvm.loop !974

103:                                              ; preds = %74
  call void @llvm.dbg.value(metadata i32 1, metadata !865, metadata !DIExpression()), !dbg !885
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %22) #3, !dbg !968
  call void @llvm.dbg.value(metadata i32 1, metadata !865, metadata !DIExpression()), !dbg !885
  br label %113

104:                                              ; preds = %25, %96
  %105 = phi i32 [ %28, %25 ], [ %98, %96 ], !dbg !885
  %106 = phi i32 [ %27, %25 ], [ %99, %96 ], !dbg !976
  call void @llvm.dbg.value(metadata i32 %105, metadata !864, metadata !DIExpression()), !dbg !885
  call void @llvm.dbg.value(metadata i32 %105, metadata !864, metadata !DIExpression()), !dbg !885
  call void @llvm.dbg.value(metadata i32 %106, metadata !865, metadata !DIExpression()), !dbg !885
  call void @llvm.dbg.value(metadata i32 %106, metadata !865, metadata !DIExpression()), !dbg !885
  call void @llvm.dbg.value(metadata i32 1, metadata !865, metadata !DIExpression()), !dbg !885
  call void @llvm.dbg.value(metadata i32 %105, metadata !864, metadata !DIExpression()), !dbg !885
  %107 = icmp eq i32 %105, 1, !dbg !977
  %108 = icmp eq i32 %106, 1, !dbg !978
  %109 = or i1 %107, %108, !dbg !979
  br i1 %109, label %110, label %113, !dbg !979

110:                                              ; preds = %104
  %111 = getelementptr inbounds [72 x i8], [72 x i8]* %4, i64 0, i64 0, !dbg !980
  call void @llvm.lifetime.start.p0i8(i64 72, i8* nonnull %111) #3, !dbg !980
  call void @llvm.dbg.declare(metadata [72 x i8]* %4, metadata !878, metadata !DIExpression()), !dbg !980
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 %111, i8* align 16 getelementptr inbounds ([72 x i8], [72 x i8]* @__const.xdp_memcached_rx_set_parse_main.____fmt, i64 0, i64 0), i64 72, i1 false), !dbg !980
  %112 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %111, i32 72) #3, !dbg !980
  call void @llvm.lifetime.end.p0i8(i64 72, i8* nonnull %111) #3, !dbg !981
  br label %113, !dbg !982

113:                                              ; preds = %103, %16, %110, %104, %1
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %14) #3, !dbg !983
  ret i32 2, !dbg !983
}

; Function Attrs: nounwind uwtable
define dso_local i32 @tc_memcached_tx_main(%struct.__sk_buff*) #0 section "tc_memcached_tx" !dbg !984 {
  %2 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.__sk_buff* %0, metadata !1075, metadata !DIExpression()), !dbg !1087
  %3 = getelementptr inbounds %struct.__sk_buff, %struct.__sk_buff* %0, i64 0, i32 16, !dbg !1088
  %4 = load i32, i32* %3, align 8, !dbg !1088, !tbaa !1089
  %5 = zext i32 %4 to i64, !dbg !1091
  %6 = inttoptr i64 %5 to i8*, !dbg !1092
  call void @llvm.dbg.value(metadata i8* %6, metadata !1076, metadata !DIExpression()), !dbg !1087
  %7 = getelementptr inbounds %struct.__sk_buff, %struct.__sk_buff* %0, i64 0, i32 15, !dbg !1093
  %8 = load i32, i32* %7, align 4, !dbg !1093, !tbaa !1094
  %9 = zext i32 %8 to i64, !dbg !1095
  %10 = inttoptr i64 %9 to i8*, !dbg !1096
  call void @llvm.dbg.value(metadata i8* %10, metadata !1077, metadata !DIExpression()), !dbg !1087
  call void @llvm.dbg.value(metadata i8* %10, metadata !1078, metadata !DIExpression()), !dbg !1087
  call void @llvm.dbg.value(metadata i8* %10, metadata !1079, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !1087
  %11 = getelementptr i8, i8* %10, i64 34, !dbg !1097
  call void @llvm.dbg.value(metadata i8* %11, metadata !1080, metadata !DIExpression()), !dbg !1087
  %12 = getelementptr i8, i8* %10, i64 50, !dbg !1098
  call void @llvm.dbg.value(metadata i8* %12, metadata !1081, metadata !DIExpression()), !dbg !1087
  %13 = bitcast i32* %2 to i8*, !dbg !1099
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %13) #3, !dbg !1099
  call void @llvm.dbg.value(metadata i32 0, metadata !1082, metadata !DIExpression()), !dbg !1087
  store i32 0, i32* %2, align 4, !dbg !1100, !tbaa !311
  %14 = getelementptr inbounds %struct.__sk_buff, %struct.__sk_buff* %0, i64 0, i32 0, !dbg !1101
  %15 = load i32, i32* %14, align 8, !dbg !1101, !tbaa !1103
  %16 = icmp ugt i32 %15, 453, !dbg !1104
  br i1 %16, label %69, label %17, !dbg !1105

17:                                               ; preds = %1
  %18 = bitcast i8* %11 to %struct.iphdr*, !dbg !1106
  %19 = inttoptr i64 %5 to %struct.iphdr*, !dbg !1108
  %20 = icmp ugt %struct.iphdr* %18, %19, !dbg !1109
  br i1 %20, label %69, label %21, !dbg !1110

21:                                               ; preds = %17
  %22 = getelementptr inbounds i8, i8* %10, i64 23, !dbg !1111
  %23 = load i8, i8* %22, align 1, !dbg !1111, !tbaa !271
  %24 = icmp eq i8 %23, 17, !dbg !1113
  br i1 %24, label %25, label %69, !dbg !1114

25:                                               ; preds = %21
  %26 = getelementptr inbounds i8, i8* %10, i64 42, !dbg !1115
  %27 = bitcast i8* %26 to %struct.udphdr*, !dbg !1115
  %28 = inttoptr i64 %5 to %struct.udphdr*, !dbg !1117
  %29 = icmp ugt %struct.udphdr* %27, %28, !dbg !1118
  br i1 %29, label %69, label %30, !dbg !1119

30:                                               ; preds = %25
  %31 = bitcast i8* %11 to i16*, !dbg !1120
  %32 = load i16, i16* %31, align 2, !dbg !1120, !tbaa !578
  call void @llvm.dbg.value(metadata i16 %32, metadata !1083, metadata !DIExpression()), !dbg !1087
  %33 = icmp eq i16 %32, -13525, !dbg !1121
  br i1 %33, label %34, label %69, !dbg !1122

34:                                               ; preds = %30
  %35 = getelementptr inbounds i8, i8* %10, i64 55, !dbg !1123
  %36 = getelementptr inbounds i8, i8* %10, i64 56, !dbg !1124
  %37 = icmp ugt i8* %36, %6, !dbg !1125
  br i1 %37, label %69, label %38, !dbg !1126

38:                                               ; preds = %34
  %39 = load i8, i8* %12, align 1, !dbg !1127, !tbaa !296
  %40 = icmp eq i8 %39, 86, !dbg !1128
  br i1 %40, label %41, label %69, !dbg !1129

41:                                               ; preds = %38
  %42 = getelementptr inbounds i8, i8* %10, i64 51, !dbg !1130
  %43 = load i8, i8* %42, align 1, !dbg !1130, !tbaa !296
  %44 = icmp eq i8 %43, 65, !dbg !1131
  br i1 %44, label %45, label %69, !dbg !1132

45:                                               ; preds = %41
  %46 = getelementptr inbounds i8, i8* %10, i64 52, !dbg !1133
  %47 = load i8, i8* %46, align 1, !dbg !1133, !tbaa !296
  %48 = icmp eq i8 %47, 76, !dbg !1134
  br i1 %48, label %49, label %69, !dbg !1135

49:                                               ; preds = %45
  %50 = getelementptr inbounds i8, i8* %10, i64 53, !dbg !1136
  %51 = load i8, i8* %50, align 1, !dbg !1136, !tbaa !296
  %52 = icmp eq i8 %51, 85, !dbg !1137
  br i1 %52, label %53, label %69, !dbg !1138

53:                                               ; preds = %49
  %54 = getelementptr inbounds i8, i8* %10, i64 54, !dbg !1139
  %55 = load i8, i8* %54, align 1, !dbg !1139, !tbaa !296
  %56 = icmp eq i8 %55, 69, !dbg !1140
  br i1 %56, label %57, label %69, !dbg !1141

57:                                               ; preds = %53
  %58 = load i8, i8* %35, align 1, !dbg !1142, !tbaa !296
  %59 = icmp eq i8 %58, 32, !dbg !1143
  br i1 %59, label %60, label %69, !dbg !1144

60:                                               ; preds = %57
  %61 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @map_stats to i8*), i8* nonnull %13) #3, !dbg !1145
  call void @llvm.dbg.value(metadata i8* %61, metadata !1084, metadata !DIExpression()), !dbg !1146
  %62 = icmp eq i8* %61, null, !dbg !1147
  br i1 %62, label %69, label %63, !dbg !1149

63:                                               ; preds = %60
  call void @llvm.dbg.value(metadata i8* %61, metadata !1084, metadata !DIExpression()), !dbg !1146
  %64 = getelementptr inbounds i8, i8* %61, i64 8, !dbg !1150
  %65 = bitcast i8* %64 to i32*, !dbg !1150
  %66 = load i32, i32* %65, align 4, !dbg !1151, !tbaa !1152
  %67 = add i32 %66, 1, !dbg !1151
  store i32 %67, i32* %65, align 4, !dbg !1151, !tbaa !1152
  %68 = bitcast %struct.__sk_buff* %0 to i8*, !dbg !1153
  call void inttoptr (i64 12 to void (i8*, i8*, i32)*)(i8* %68, i8* bitcast (%struct.bpf_map_def* @map_progs_tc to i8*), i32 0) #3, !dbg !1154
  br label %69

69:                                               ; preds = %60, %63, %34, %57, %53, %49, %45, %41, %38, %30, %25, %21, %17, %1
  %70 = phi i32 [ 0, %1 ], [ 2, %17 ], [ 0, %21 ], [ 0, %25 ], [ 2, %60 ], [ 0, %63 ], [ 0, %34 ], [ 0, %57 ], [ 0, %53 ], [ 0, %49 ], [ 0, %45 ], [ 0, %41 ], [ 0, %38 ], [ 0, %30 ], !dbg !1087
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %13) #3, !dbg !1155
  ret i32 %70, !dbg !1155
}

; Function Attrs: nounwind uwtable
define dso_local i32 @tc_memcached_tx_get_parse_main(%struct.__sk_buff* nocapture readonly) #0 section "tc_memcached_tx_get_parse" !dbg !1156 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca [70 x i8], align 16
  %5 = alloca [59 x i8], align 16
  %6 = alloca [63 x i8], align 16
  %7 = alloca [59 x i8], align 16
  %8 = alloca [54 x i8], align 16
  %9 = alloca [59 x i8], align 16
  call void @llvm.dbg.value(metadata %struct.__sk_buff* %0, metadata !1158, metadata !DIExpression()), !dbg !1210
  %10 = getelementptr inbounds %struct.__sk_buff, %struct.__sk_buff* %0, i64 0, i32 16, !dbg !1211
  %11 = load i32, i32* %10, align 8, !dbg !1211, !tbaa !1089
  %12 = zext i32 %11 to i64, !dbg !1212
  %13 = inttoptr i64 %12 to i8*, !dbg !1213
  call void @llvm.dbg.value(metadata i8* %13, metadata !1159, metadata !DIExpression()), !dbg !1210
  %14 = getelementptr inbounds %struct.__sk_buff, %struct.__sk_buff* %0, i64 0, i32 15, !dbg !1214
  %15 = load i32, i32* %14, align 4, !dbg !1214, !tbaa !1094
  %16 = zext i32 %15 to i64, !dbg !1215
  %17 = inttoptr i64 %16 to i8*, !dbg !1216
  call void @llvm.dbg.value(metadata i8* %17, metadata !1160, metadata !DIExpression()), !dbg !1210
  %18 = getelementptr i8, i8* %17, i64 50, !dbg !1217
  call void @llvm.dbg.value(metadata i8* %18, metadata !1161, metadata !DIExpression()), !dbg !1210
  %19 = bitcast i32* %2 to i8*, !dbg !1218
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %19) #3, !dbg !1218
  call void @llvm.dbg.value(metadata i32 0, metadata !1162, metadata !DIExpression()), !dbg !1210
  store i32 0, i32* %2, align 4, !dbg !1219, !tbaa !311
  call void @llvm.dbg.value(metadata i32 -2128831035, metadata !1163, metadata !DIExpression()), !dbg !1210
  call void @llvm.dbg.value(metadata i32 -2128831035, metadata !1164, metadata !DIExpression()), !dbg !1210
  call void @llvm.dbg.value(metadata i32 6, metadata !1165, metadata !DIExpression()), !dbg !1220
  br label %20, !dbg !1221

20:                                               ; preds = %38, %1
  %21 = phi i64 [ 6, %1 ], [ %43, %38 ]
  %22 = phi i32 [ -2128831035, %1 ], [ %40, %38 ]
  %23 = phi i32 [ -2128831035, %1 ], [ %42, %38 ]
  call void @llvm.dbg.value(metadata i32 %22, metadata !1163, metadata !DIExpression()), !dbg !1210
  call void @llvm.dbg.value(metadata i32 %23, metadata !1164, metadata !DIExpression()), !dbg !1210
  call void @llvm.dbg.value(metadata i64 %21, metadata !1165, metadata !DIExpression()), !dbg !1220
  %24 = getelementptr inbounds i8, i8* %18, i64 %21, !dbg !1223
  %25 = getelementptr inbounds i8, i8* %24, i64 1, !dbg !1224
  %26 = icmp ugt i8* %25, %13, !dbg !1225
  br i1 %26, label %31, label %27, !dbg !1226

27:                                               ; preds = %20
  %28 = load i8, i8* %24, align 1, !dbg !1227, !tbaa !296
  %29 = sext i8 %28 to i32, !dbg !1227
  %30 = icmp eq i8 %28, 32, !dbg !1228
  br i1 %30, label %31, label %38, !dbg !1229

31:                                               ; preds = %38, %27, %20
  %32 = phi i32 [ %23, %27 ], [ %23, %20 ], [ %42, %38 ], !dbg !1210
  %33 = phi i32 [ %22, %27 ], [ %22, %20 ], [ %40, %38 ], !dbg !1210
  call void @llvm.dbg.value(metadata i32 %32, metadata !1164, metadata !DIExpression()), !dbg !1210
  call void @llvm.dbg.value(metadata i32 %32, metadata !1164, metadata !DIExpression()), !dbg !1210
  call void @llvm.dbg.value(metadata i32 %32, metadata !1164, metadata !DIExpression()), !dbg !1210
  call void @llvm.dbg.value(metadata i32 %33, metadata !1163, metadata !DIExpression()), !dbg !1210
  call void @llvm.dbg.value(metadata i32 %33, metadata !1163, metadata !DIExpression()), !dbg !1210
  call void @llvm.dbg.value(metadata i32 %33, metadata !1163, metadata !DIExpression()), !dbg !1210
  %34 = bitcast i32* %3 to i8*, !dbg !1230
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %34) #3, !dbg !1230
  %35 = urem i32 %33, 2777777, !dbg !1231
  call void @llvm.dbg.value(metadata i32 %35, metadata !1167, metadata !DIExpression()), !dbg !1210
  store i32 %35, i32* %3, align 4, !dbg !1232, !tbaa !311
  %36 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.anon.0* @map_kcache to i8*), i8* nonnull %34) #3, !dbg !1233
  call void @llvm.dbg.value(metadata i8* %36, metadata !1168, metadata !DIExpression()), !dbg !1210
  %37 = icmp eq i8* %36, null, !dbg !1234
  br i1 %37, label %250, label %45, !dbg !1236

38:                                               ; preds = %27
  %39 = xor i32 %22, %29, !dbg !1237
  call void @llvm.dbg.value(metadata i32 %39, metadata !1163, metadata !DIExpression()), !dbg !1210
  %40 = mul i32 %39, 16777619, !dbg !1239
  %41 = xor i32 %23, %29, !dbg !1240
  call void @llvm.dbg.value(metadata i32 %41, metadata !1164, metadata !DIExpression()), !dbg !1210
  %42 = mul i32 %41, 83227, !dbg !1241
  %43 = add nuw nsw i64 %21, 1, !dbg !1242
  call void @llvm.dbg.value(metadata i32 %40, metadata !1163, metadata !DIExpression()), !dbg !1210
  call void @llvm.dbg.value(metadata i32 %42, metadata !1164, metadata !DIExpression()), !dbg !1210
  call void @llvm.dbg.value(metadata i32 undef, metadata !1165, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !1220
  %44 = icmp eq i64 %43, 256, !dbg !1243
  br i1 %44, label %31, label %20, !dbg !1221, !llvm.loop !1244

45:                                               ; preds = %31
  call void @llvm.dbg.value(metadata i32 -1, metadata !1169, metadata !DIExpression()), !dbg !1210
  %46 = getelementptr inbounds i8, i8* %17, i64 83, !dbg !1246
  %47 = icmp ugt i8* %46, %13, !dbg !1248
  br i1 %47, label %67, label %48, !dbg !1249

48:                                               ; preds = %45
  %49 = getelementptr inbounds i8, i8* %17, i64 79, !dbg !1250
  %50 = load i8, i8* %49, align 1, !dbg !1251, !tbaa !296
  %51 = zext i8 %50 to i32, !dbg !1253
  %52 = shl nuw i32 %51, 24, !dbg !1254
  %53 = getelementptr inbounds i8, i8* %17, i64 80, !dbg !1255
  %54 = load i8, i8* %53, align 1, !dbg !1255, !tbaa !296
  %55 = sext i8 %54 to i32, !dbg !1256
  %56 = shl nsw i32 %55, 16, !dbg !1257
  %57 = add i32 %56, %52, !dbg !1258
  %58 = getelementptr inbounds i8, i8* %17, i64 81, !dbg !1259
  %59 = load i8, i8* %58, align 1, !dbg !1259, !tbaa !296
  %60 = sext i8 %59 to i32, !dbg !1260
  %61 = shl nsw i32 %60, 8, !dbg !1261
  %62 = add i32 %57, %61, !dbg !1262
  %63 = getelementptr inbounds i8, i8* %17, i64 82, !dbg !1263
  %64 = load i8, i8* %63, align 1, !dbg !1263, !tbaa !296
  %65 = sext i8 %64 to i32, !dbg !1264
  %66 = add i32 %62, %65, !dbg !1265
  call void @llvm.dbg.value(metadata i32 %66, metadata !1169, metadata !DIExpression()), !dbg !1210
  br label %67, !dbg !1266

67:                                               ; preds = %45, %48
  %68 = phi i32 [ %66, %48 ], [ -1, %45 ], !dbg !1210
  call void @llvm.dbg.value(metadata i32 %68, metadata !1169, metadata !DIExpression()), !dbg !1210
  %69 = bitcast i8* %36 to %struct.bpf_spin_lock*, !dbg !1267
  call void inttoptr (i64 93 to void (%struct.bpf_spin_lock*)*)(%struct.bpf_spin_lock* nonnull %69) #3, !dbg !1268
  %70 = getelementptr inbounds i8, i8* %36, i64 8, !dbg !1269
  %71 = load i8, i8* %70, align 4, !dbg !1269, !tbaa !453
  %72 = icmp eq i8 %71, 0, !dbg !1270
  br i1 %72, label %123, label %73, !dbg !1271

73:                                               ; preds = %67
  %74 = getelementptr inbounds i8, i8* %36, i64 12, !dbg !1272
  %75 = bitcast i8* %74 to i32*, !dbg !1272
  %76 = load i32, i32* %75, align 4, !dbg !1272, !tbaa !459
  %77 = icmp eq i32 %76, %33, !dbg !1273
  br i1 %77, label %78, label %104, !dbg !1274

78:                                               ; preds = %73
  call void @llvm.dbg.value(metadata i32 6, metadata !1173, metadata !DIExpression()), !dbg !1275
  %79 = getelementptr inbounds i8, i8* %36, i64 4, !dbg !1276
  %80 = bitcast i8* %79 to i32*, !dbg !1276
  %81 = getelementptr inbounds i8, i8* %36, i64 20, !dbg !1276
  br label %85, !dbg !1278

82:                                               ; preds = %101
  %83 = add nuw nsw i64 %86, 1, !dbg !1279
  call void @llvm.dbg.value(metadata i32 undef, metadata !1173, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !1275
  call void @llvm.dbg.value(metadata i32 undef, metadata !1173, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !1275
  %84 = icmp eq i64 %83, 256, !dbg !1280
  br i1 %84, label %103, label %85, !dbg !1278, !llvm.loop !1281

85:                                               ; preds = %82, %78
  %86 = phi i64 [ 6, %78 ], [ %83, %82 ]
  call void @llvm.dbg.value(metadata i64 %86, metadata !1173, metadata !DIExpression()), !dbg !1275
  %87 = getelementptr inbounds i8, i8* %18, i64 %86, !dbg !1284
  %88 = getelementptr inbounds i8, i8* %87, i64 1, !dbg !1285
  %89 = icmp ugt i8* %88, %13, !dbg !1286
  br i1 %89, label %103, label %90, !dbg !1287

90:                                               ; preds = %85
  %91 = load i32, i32* %80, align 4, !dbg !1288, !tbaa !674
  %92 = zext i32 %91 to i64, !dbg !1289
  %93 = icmp ult i64 %86, %92, !dbg !1289
  br i1 %93, label %94, label %103, !dbg !1290

94:                                               ; preds = %90
  %95 = load i8, i8* %87, align 1, !dbg !1291, !tbaa !296
  %96 = icmp eq i8 %95, 32, !dbg !1292
  %97 = getelementptr inbounds i8, i8* %81, i64 %86, !dbg !1276
  %98 = load i8, i8* %97, align 1, !dbg !1276, !tbaa !296
  %99 = icmp eq i8 %98, 32, !dbg !1293
  %100 = and i1 %96, %99, !dbg !1294
  br i1 %100, label %103, label %101, !dbg !1294

101:                                              ; preds = %94
  %102 = icmp eq i8 %98, %95, !dbg !1295
  call void @llvm.dbg.value(metadata i64 %86, metadata !1173, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !1275
  br i1 %102, label %82, label %104, !dbg !1298

103:                                              ; preds = %94, %82, %90, %85
  call void inttoptr (i64 94 to void (%struct.bpf_spin_lock*)*)(%struct.bpf_spin_lock* nonnull %69) #3, !dbg !1299
  br label %250

104:                                              ; preds = %101, %73
  %105 = icmp sgt i8 %71, 1, !dbg !1302
  br i1 %105, label %106, label %123, !dbg !1303

106:                                              ; preds = %104
  %107 = getelementptr inbounds i8, i8* %36, i64 16, !dbg !1304
  %108 = bitcast i8* %107 to i32*, !dbg !1304
  %109 = load i32, i32* %108, align 4, !dbg !1304, !tbaa !733
  %110 = icmp eq i32 %109, %32, !dbg !1305
  br i1 %110, label %123, label %111, !dbg !1306

111:                                              ; preds = %106
  store i32 %32, i32* %108, align 4, !dbg !1307, !tbaa !733
  call void inttoptr (i64 94 to void (%struct.bpf_spin_lock*)*)(%struct.bpf_spin_lock* nonnull %69) #3, !dbg !1308
  %112 = getelementptr inbounds [70 x i8], [70 x i8]* %4, i64 0, i64 0, !dbg !1309
  call void @llvm.lifetime.start.p0i8(i64 70, i8* nonnull %112) #3, !dbg !1309
  call void @llvm.dbg.declare(metadata [70 x i8]* %4, metadata !1175, metadata !DIExpression()), !dbg !1309
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 %112, i8* align 16 getelementptr inbounds ([70 x i8], [70 x i8]* @__const.tc_memcached_tx_get_parse_main.____fmt, i64 0, i64 0), i64 70, i1 false), !dbg !1309
  %113 = load i32, i32* %75, align 4, !dbg !1309, !tbaa !459
  %114 = load i8, i8* %70, align 4, !dbg !1309, !tbaa !453
  %115 = sext i8 %114 to i32, !dbg !1309
  %116 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %112, i32 70, i32 %113, i32 %115, i32 %32) #3, !dbg !1309
  call void @llvm.lifetime.end.p0i8(i64 70, i8* nonnull %112) #3, !dbg !1310
  %117 = getelementptr inbounds [59 x i8], [59 x i8]* %5, i64 0, i64 0, !dbg !1311
  call void @llvm.lifetime.start.p0i8(i64 59, i8* nonnull %117) #3, !dbg !1311
  call void @llvm.dbg.declare(metadata [59 x i8]* %5, metadata !1182, metadata !DIExpression()), !dbg !1311
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 %117, i8* align 16 getelementptr inbounds ([59 x i8], [59 x i8]* @__const.tc_memcached_tx_get_parse_main.____fmt.5, i64 0, i64 0), i64 59, i1 false), !dbg !1311
  %118 = load i32, i32* %108, align 4, !dbg !1311, !tbaa !733
  %119 = getelementptr inbounds i8, i8* %36, i64 26, !dbg !1311
  %120 = load i8, i8* %119, align 2, !dbg !1311, !tbaa !296
  %121 = sext i8 %120 to i32, !dbg !1311
  %122 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %117, i32 59, i32 %118, i32 %33, i32 %121) #3, !dbg !1311
  call void @llvm.lifetime.end.p0i8(i64 59, i8* nonnull %117) #3, !dbg !1312
  br label %250, !dbg !1313

123:                                              ; preds = %67, %106, %104
  %124 = getelementptr inbounds i8, i8* %36, i64 16, !dbg !1314
  %125 = bitcast i8* %124 to i32*, !dbg !1314
  %126 = load i32, i32* %125, align 4, !dbg !1314, !tbaa !733
  %127 = icmp eq i32 %126, %32, !dbg !1315
  br i1 %127, label %128, label %145, !dbg !1316

128:                                              ; preds = %123
  %129 = add i8 %71, -1, !dbg !1317
  store i8 %129, i8* %70, align 4, !dbg !1317, !tbaa !453
  %130 = icmp sgt i8 %129, 1, !dbg !1318
  br i1 %130, label %131, label %145, !dbg !1319

131:                                              ; preds = %128
  call void inttoptr (i64 94 to void (%struct.bpf_spin_lock*)*)(%struct.bpf_spin_lock* nonnull %69) #3, !dbg !1320
  %132 = getelementptr inbounds [63 x i8], [63 x i8]* %6, i64 0, i64 0, !dbg !1321
  call void @llvm.lifetime.start.p0i8(i64 63, i8* nonnull %132) #3, !dbg !1321
  call void @llvm.dbg.declare(metadata [63 x i8]* %6, metadata !1187, metadata !DIExpression()), !dbg !1321
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 %132, i8* align 16 getelementptr inbounds ([63 x i8], [63 x i8]* @__const.tc_memcached_tx_get_parse_main.____fmt.2, i64 0, i64 0), i64 63, i1 false), !dbg !1321
  %133 = getelementptr inbounds i8, i8* %36, i64 12, !dbg !1321
  %134 = bitcast i8* %133 to i32*, !dbg !1321
  %135 = load i32, i32* %134, align 4, !dbg !1321, !tbaa !459
  %136 = load i8, i8* %70, align 4, !dbg !1321, !tbaa !453
  %137 = sext i8 %136 to i32, !dbg !1321
  %138 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %132, i32 63, i32 %135, i32 %137, i32 %32) #3, !dbg !1321
  call void @llvm.lifetime.end.p0i8(i64 63, i8* nonnull %132) #3, !dbg !1322
  %139 = getelementptr inbounds [59 x i8], [59 x i8]* %7, i64 0, i64 0, !dbg !1323
  call void @llvm.lifetime.start.p0i8(i64 59, i8* nonnull %139) #3, !dbg !1323
  call void @llvm.dbg.declare(metadata [59 x i8]* %7, metadata !1194, metadata !DIExpression()), !dbg !1323
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 %139, i8* align 16 getelementptr inbounds ([59 x i8], [59 x i8]* @__const.tc_memcached_tx_get_parse_main.____fmt.5, i64 0, i64 0), i64 59, i1 false), !dbg !1323
  %140 = load i32, i32* %125, align 4, !dbg !1323, !tbaa !733
  %141 = getelementptr inbounds i8, i8* %36, i64 26, !dbg !1323
  %142 = load i8, i8* %141, align 2, !dbg !1323, !tbaa !296
  %143 = sext i8 %142 to i32, !dbg !1323
  %144 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %139, i32 59, i32 %140, i32 %33, i32 %143) #3, !dbg !1323
  call void @llvm.lifetime.end.p0i8(i64 59, i8* nonnull %139) #3, !dbg !1324
  br label %250, !dbg !1325

145:                                              ; preds = %123, %128
  %146 = phi i8 [ %129, %128 ], [ %71, %123 ], !dbg !1326
  call void @llvm.dbg.value(metadata i32 -1, metadata !1196, metadata !DIExpression()), !dbg !1210
  %147 = icmp sgt i8 %146, 0, !dbg !1328
  br i1 %147, label %148, label %167, !dbg !1329

148:                                              ; preds = %145
  %149 = getelementptr inbounds i8, i8* %36, i64 49, !dbg !1330
  %150 = load i8, i8* %149, align 1, !dbg !1330, !tbaa !296
  %151 = zext i8 %150 to i32, !dbg !1332
  %152 = shl nuw i32 %151, 24, !dbg !1333
  %153 = getelementptr inbounds i8, i8* %36, i64 50, !dbg !1334
  %154 = load i8, i8* %153, align 2, !dbg !1334, !tbaa !296
  %155 = sext i8 %154 to i32, !dbg !1335
  %156 = shl nsw i32 %155, 16, !dbg !1336
  %157 = add i32 %156, %152, !dbg !1337
  %158 = getelementptr inbounds i8, i8* %36, i64 51, !dbg !1338
  %159 = load i8, i8* %158, align 1, !dbg !1338, !tbaa !296
  %160 = sext i8 %159 to i32, !dbg !1339
  %161 = shl nsw i32 %160, 8, !dbg !1340
  %162 = add i32 %157, %161, !dbg !1341
  %163 = getelementptr inbounds i8, i8* %36, i64 52, !dbg !1342
  %164 = load i8, i8* %163, align 4, !dbg !1342, !tbaa !296
  %165 = sext i8 %164 to i32, !dbg !1343
  %166 = add i32 %162, %165, !dbg !1344
  call void @llvm.dbg.value(metadata i32 %166, metadata !1196, metadata !DIExpression()), !dbg !1210
  br label %167, !dbg !1345

167:                                              ; preds = %148, %145
  %168 = phi i32 [ %166, %148 ], [ -1, %145 ], !dbg !1210
  call void @llvm.dbg.value(metadata i32 %168, metadata !1196, metadata !DIExpression()), !dbg !1210
  call void @llvm.dbg.value(metadata i32 0, metadata !1197, metadata !DIExpression()), !dbg !1210
  %169 = getelementptr inbounds i8, i8* %36, i64 4, !dbg !1346
  %170 = bitcast i8* %169 to i32*, !dbg !1346
  store i32 0, i32* %170, align 4, !dbg !1347, !tbaa !674
  call void @llvm.dbg.value(metadata i32 0, metadata !1198, metadata !DIExpression()), !dbg !1348
  call void @llvm.dbg.value(metadata i32 0, metadata !1197, metadata !DIExpression()), !dbg !1210
  %171 = getelementptr inbounds i8, i8* %36, i64 20, !dbg !1349
  br label %172, !dbg !1352

172:                                              ; preds = %184, %167
  %173 = phi i32 [ 0, %167 ], [ %187, %184 ]
  %174 = phi i64 [ 0, %167 ], [ %192, %184 ]
  %175 = phi i32 [ 0, %167 ], [ %191, %184 ]
  call void @llvm.dbg.value(metadata i64 %174, metadata !1198, metadata !DIExpression()), !dbg !1348
  call void @llvm.dbg.value(metadata i32 %175, metadata !1197, metadata !DIExpression()), !dbg !1210
  %176 = getelementptr inbounds i8, i8* %18, i64 %174, !dbg !1353
  %177 = getelementptr inbounds i8, i8* %176, i64 1, !dbg !1354
  %178 = icmp ule i8* %177, %13, !dbg !1355
  %179 = icmp ult i32 %175, 2, !dbg !1356
  %180 = and i1 %179, %178, !dbg !1357
  br i1 %180, label %184, label %181, !dbg !1357

181:                                              ; preds = %184, %172
  %182 = phi i32 [ %191, %184 ], [ %175, %172 ], !dbg !1210
  call void @llvm.dbg.value(metadata i32 %182, metadata !1197, metadata !DIExpression()), !dbg !1210
  call void @llvm.dbg.value(metadata i32 %182, metadata !1197, metadata !DIExpression()), !dbg !1210
  %183 = icmp eq i32 %182, 2, !dbg !1358
  br i1 %183, label %194, label %235, !dbg !1359

184:                                              ; preds = %172
  %185 = load i8, i8* %176, align 1, !dbg !1360, !tbaa !296
  %186 = getelementptr inbounds i8, i8* %171, i64 %174, !dbg !1361
  store i8 %185, i8* %186, align 1, !dbg !1362, !tbaa !296
  %187 = add i32 %173, 1, !dbg !1363
  store i32 %187, i32* %170, align 4, !dbg !1363, !tbaa !674
  %188 = load i8, i8* %176, align 1, !dbg !1364, !tbaa !296
  %189 = icmp eq i8 %188, 10, !dbg !1366
  %190 = zext i1 %189 to i32, !dbg !1367
  %191 = add nuw nsw i32 %175, %190, !dbg !1367
  %192 = add nuw nsw i64 %174, 1, !dbg !1368
  call void @llvm.dbg.value(metadata i32 undef, metadata !1198, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)), !dbg !1348
  call void @llvm.dbg.value(metadata i32 %191, metadata !1197, metadata !DIExpression()), !dbg !1210
  %193 = icmp eq i64 %192, 403, !dbg !1369
  br i1 %193, label %181, label %172, !dbg !1352, !llvm.loop !1370

194:                                              ; preds = %181
  store i8 17, i8* %70, align 4, !dbg !1373, !tbaa !453
  %195 = getelementptr inbounds i8, i8* %36, i64 12, !dbg !1374
  %196 = bitcast i8* %195 to i32*, !dbg !1374
  store i32 %33, i32* %196, align 4, !dbg !1375, !tbaa !459
  store i32 0, i32* %125, align 4, !dbg !1376, !tbaa !733
  call void inttoptr (i64 94 to void (%struct.bpf_spin_lock*)*)(%struct.bpf_spin_lock* nonnull %69) #3, !dbg !1377
  %197 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* bitcast (%struct.bpf_map_def* @map_stats to i8*), i8* nonnull %19) #3, !dbg !1378
  call void @llvm.dbg.value(metadata i8* %197, metadata !1200, metadata !DIExpression()), !dbg !1379
  %198 = icmp eq i8* %197, null, !dbg !1380
  br i1 %198, label %250, label %199, !dbg !1382

199:                                              ; preds = %194
  %200 = getelementptr inbounds i8, i8* %197, i64 24, !dbg !1383
  %201 = bitcast i8* %200 to i32*, !dbg !1383
  %202 = load i32, i32* %201, align 4, !dbg !1384, !tbaa !1385
  %203 = add i32 %202, 1, !dbg !1384
  store i32 %203, i32* %201, align 4, !dbg !1384, !tbaa !1385
  %204 = icmp ult i32 %168, 3500000, !dbg !1386
  %205 = icmp ult i32 %68, 3500000, !dbg !1388
  %206 = and i1 %205, %204, !dbg !1389
  br i1 %206, label %207, label %212, !dbg !1389

207:                                              ; preds = %199
  %208 = getelementptr inbounds i8, i8* %197, i64 32, !dbg !1390
  %209 = bitcast i8* %208 to i32*, !dbg !1390
  %210 = load i32, i32* %209, align 4, !dbg !1392, !tbaa !1393
  %211 = add i32 %210, 1, !dbg !1392
  store i32 %211, i32* %209, align 4, !dbg !1392, !tbaa !1393
  br label %236, !dbg !1394

212:                                              ; preds = %199
  %213 = icmp ugt i32 %168, 3499999, !dbg !1395
  %214 = icmp ugt i32 %68, 3499999, !dbg !1397
  %215 = and i1 %214, %213, !dbg !1398
  br i1 %215, label %216, label %221, !dbg !1398

216:                                              ; preds = %212
  %217 = getelementptr inbounds i8, i8* %197, i64 36, !dbg !1399
  %218 = bitcast i8* %217 to i32*, !dbg !1399
  %219 = load i32, i32* %218, align 4, !dbg !1401, !tbaa !1402
  %220 = add i32 %219, 1, !dbg !1401
  store i32 %220, i32* %218, align 4, !dbg !1401, !tbaa !1402
  br label %236, !dbg !1403

221:                                              ; preds = %212
  %222 = and i1 %205, %213, !dbg !1404
  br i1 %222, label %223, label %228, !dbg !1404

223:                                              ; preds = %221
  %224 = getelementptr inbounds i8, i8* %197, i64 40, !dbg !1406
  %225 = bitcast i8* %224 to i32*, !dbg !1406
  %226 = load i32, i32* %225, align 4, !dbg !1408, !tbaa !1409
  %227 = add i32 %226, 1, !dbg !1408
  store i32 %227, i32* %225, align 4, !dbg !1408, !tbaa !1409
  br label %236, !dbg !1410

228:                                              ; preds = %221
  %229 = and i1 %214, %204, !dbg !1411
  br i1 %229, label %230, label %236, !dbg !1411

230:                                              ; preds = %228
  %231 = getelementptr inbounds i8, i8* %197, i64 44, !dbg !1413
  %232 = bitcast i8* %231 to i32*, !dbg !1413
  %233 = load i32, i32* %232, align 4, !dbg !1415, !tbaa !1416
  %234 = add i32 %233, 1, !dbg !1415
  store i32 %234, i32* %232, align 4, !dbg !1415, !tbaa !1416
  br label %236, !dbg !1417

235:                                              ; preds = %181
  call void inttoptr (i64 94 to void (%struct.bpf_spin_lock*)*)(%struct.bpf_spin_lock* nonnull %69) #3, !dbg !1418
  br label %236

236:                                              ; preds = %207, %223, %230, %228, %216, %235
  %237 = getelementptr inbounds [54 x i8], [54 x i8]* %8, i64 0, i64 0, !dbg !1420
  call void @llvm.lifetime.start.p0i8(i64 54, i8* nonnull %237) #3, !dbg !1420
  call void @llvm.dbg.declare(metadata [54 x i8]* %8, metadata !1203, metadata !DIExpression()), !dbg !1420
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 %237, i8* align 16 getelementptr inbounds ([54 x i8], [54 x i8]* @__const.tc_memcached_tx_get_parse_main.____fmt.4, i64 0, i64 0), i64 54, i1 false), !dbg !1420
  %238 = getelementptr inbounds i8, i8* %36, i64 12, !dbg !1420
  %239 = bitcast i8* %238 to i32*, !dbg !1420
  %240 = load i32, i32* %239, align 4, !dbg !1420, !tbaa !459
  %241 = load i8, i8* %70, align 4, !dbg !1420, !tbaa !453
  %242 = sext i8 %241 to i32, !dbg !1420
  %243 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %237, i32 54, i32 %240, i32 %242, i32 %32) #3, !dbg !1420
  call void @llvm.lifetime.end.p0i8(i64 54, i8* nonnull %237) #3, !dbg !1421
  %244 = getelementptr inbounds [59 x i8], [59 x i8]* %9, i64 0, i64 0, !dbg !1422
  call void @llvm.lifetime.start.p0i8(i64 59, i8* nonnull %244) #3, !dbg !1422
  call void @llvm.dbg.declare(metadata [59 x i8]* %9, metadata !1208, metadata !DIExpression()), !dbg !1422
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 %244, i8* align 16 getelementptr inbounds ([59 x i8], [59 x i8]* @__const.tc_memcached_tx_get_parse_main.____fmt.5, i64 0, i64 0), i64 59, i1 false), !dbg !1422
  %245 = load i32, i32* %125, align 4, !dbg !1422, !tbaa !733
  %246 = getelementptr inbounds i8, i8* %36, i64 26, !dbg !1422
  %247 = load i8, i8* %246, align 2, !dbg !1422, !tbaa !296
  %248 = sext i8 %247 to i32, !dbg !1422
  %249 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* nonnull %244, i32 59, i32 %245, i32 %33, i32 %248) #3, !dbg !1422
  call void @llvm.lifetime.end.p0i8(i64 59, i8* nonnull %244) #3, !dbg !1423
  br label %250, !dbg !1424

250:                                              ; preds = %194, %111, %131, %103, %236, %31
  %251 = phi i32 [ 0, %31 ], [ 0, %111 ], [ 0, %131 ], [ 0, %103 ], [ 0, %236 ], [ 2, %194 ], !dbg !1210
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %34) #3, !dbg !1425
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %19) #3, !dbg !1425
  ret i32 %251, !dbg !1425
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

; Function Attrs: nounwind readnone speculatable
declare i16 @llvm.bswap.i16(i16) #1

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!171, !172, !173}
!llvm.ident = !{!174}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "map_parsing_context", scope: !2, file: !3, line: 90, type: !58, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 9.0.1-12 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !55, nameTableKind: None)
!3 = !DIFile(filename: "memcached_bpf_kern.c", directory: "/home/leif/stage/bmc-cache/bmc2")
!4 = !{}
!5 = !{!6, !7, !8, !22, !13, !15, !46, !48, !50, !51, !53}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!7 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "udphdr", file: !10, line: 23, size: 64, elements: !11)
!10 = !DIFile(filename: "./linux/include/uapi/linux/udp.h", directory: "/home/leif/stage/bmc-cache/bmc2")
!11 = !{!12, !18, !19, !20}
!12 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !9, file: !10, line: 24, baseType: !13, size: 16)
!13 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !14, line: 30, baseType: !15)
!14 = !DIFile(filename: "./linux/include/uapi/linux/types.h", directory: "/home/leif/stage/bmc-cache/bmc2")
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !16, line: 24, baseType: !17)
!16 = !DIFile(filename: "./linux/include/uapi/asm-generic/int-ll64.h", directory: "/home/leif/stage/bmc-cache/bmc2")
!17 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !9, file: !10, line: 25, baseType: !13, size: 16, offset: 16)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !9, file: !10, line: 26, baseType: !13, size: 16, offset: 32)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !9, file: !10, line: 27, baseType: !21, size: 16, offset: 48)
!21 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !14, line: 36, baseType: !15)
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !24, line: 25, size: 160, elements: !25)
!24 = !DIFile(filename: "./linux/include/uapi/linux/tcp.h", directory: "/home/leif/stage/bmc-cache/bmc2")
!25 = !{!26, !27, !28, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42, !43, !44, !45}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !23, file: !24, line: 26, baseType: !13, size: 16)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !23, file: !24, line: 27, baseType: !13, size: 16, offset: 16)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !23, file: !24, line: 28, baseType: !29, size: 32, offset: 32)
!29 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !14, line: 32, baseType: !30)
!30 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !16, line: 27, baseType: !31)
!31 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !23, file: !24, line: 29, baseType: !29, size: 32, offset: 64)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !23, file: !24, line: 31, baseType: !15, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!34 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !23, file: !24, line: 32, baseType: !15, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !23, file: !24, line: 33, baseType: !15, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !23, file: !24, line: 34, baseType: !15, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !23, file: !24, line: 35, baseType: !15, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !23, file: !24, line: 36, baseType: !15, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!39 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !23, file: !24, line: 37, baseType: !15, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!40 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !23, file: !24, line: 38, baseType: !15, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!41 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !23, file: !24, line: 39, baseType: !15, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!42 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !23, file: !24, line: 40, baseType: !15, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!43 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !23, file: !24, line: 55, baseType: !13, size: 16, offset: 112)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !23, file: !24, line: 56, baseType: !21, size: 16, offset: 128)
!45 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !23, file: !24, line: 57, baseType: !13, size: 16, offset: 144)
!46 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !47, size: 64)
!47 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!48 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !49, size: 64)
!49 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!50 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!51 = !DIDerivedType(tag: DW_TAG_typedef, name: "u32", file: !52, line: 21, baseType: !30)
!52 = !DIFile(filename: "./linux/include/asm-generic/int-ll64.h", directory: "/home/leif/stage/bmc-cache/bmc2")
!53 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !54, size: 64)
!54 = !DIDerivedType(tag: DW_TAG_typedef, name: "u16", file: !52, line: 19, baseType: !15)
!55 = !{!0, !56, !68, !70, !72, !77, !111, !137, !144, !149, !154, !160, !162, !164}
!56 = !DIGlobalVariableExpression(var: !57, expr: !DIExpression())
!57 = distinct !DIGlobalVariable(name: "map_stats", scope: !2, file: !3, line: 98, type: !58, isLocal: false, isDefinition: true)
!58 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map_def", file: !59, line: 246, size: 224, elements: !60)
!59 = !DIFile(filename: "./linux/tools/testing/selftests/bpf/bpf_helpers.h", directory: "/home/leif/stage/bmc-cache/bmc2")
!60 = !{!61, !62, !63, !64, !65, !66, !67}
!61 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !58, file: !59, line: 247, baseType: !31, size: 32)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !58, file: !59, line: 248, baseType: !31, size: 32, offset: 32)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !58, file: !59, line: 249, baseType: !31, size: 32, offset: 64)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !58, file: !59, line: 250, baseType: !31, size: 32, offset: 96)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !58, file: !59, line: 251, baseType: !31, size: 32, offset: 128)
!66 = !DIDerivedType(tag: DW_TAG_member, name: "inner_map_idx", scope: !58, file: !59, line: 252, baseType: !31, size: 32, offset: 160)
!67 = !DIDerivedType(tag: DW_TAG_member, name: "numa_node", scope: !58, file: !59, line: 253, baseType: !31, size: 32, offset: 192)
!68 = !DIGlobalVariableExpression(var: !69, expr: !DIExpression())
!69 = distinct !DIGlobalVariable(name: "map_progs_xdp", scope: !2, file: !3, line: 106, type: !58, isLocal: false, isDefinition: true)
!70 = !DIGlobalVariableExpression(var: !71, expr: !DIExpression())
!71 = distinct !DIGlobalVariable(name: "map_progs_tc", scope: !2, file: !3, line: 113, type: !58, isLocal: false, isDefinition: true)
!72 = !DIGlobalVariableExpression(var: !73, expr: !DIExpression())
!73 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 688, type: !74, isLocal: false, isDefinition: true)
!74 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, size: 32, elements: !75)
!75 = !{!76}
!76 = !DISubrange(count: 4)
!77 = !DIGlobalVariableExpression(var: !78, expr: !DIExpression())
!78 = distinct !DIGlobalVariable(name: "map_kcache", scope: !2, file: !3, line: 66, type: !79, isLocal: false, isDefinition: true)
!79 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 61, size: 256, elements: !80)
!80 = !{!81, !86, !88, !106}
!81 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !79, file: !3, line: 62, baseType: !82, size: 64)
!82 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !83, size: 64)
!83 = !DICompositeType(tag: DW_TAG_array_type, baseType: !50, size: 64, elements: !84)
!84 = !{!85}
!85 = !DISubrange(count: 2)
!86 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !79, file: !3, line: 63, baseType: !87, size: 64, offset: 64)
!87 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !51, size: 64)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !79, file: !3, line: 64, baseType: !89, size: 64, offset: 128)
!89 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !90, size: 64)
!90 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "memcached_cache_entry", file: !91, line: 40, size: 3392, elements: !92)
!91 = !DIFile(filename: "./memcached_bpf_common.h", directory: "/home/leif/stage/bmc-cache/bmc2")
!92 = !{!93, !98, !99, !100, !101, !102}
!93 = !DIDerivedType(tag: DW_TAG_member, name: "lock", scope: !90, file: !91, line: 41, baseType: !94, size: 32)
!94 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_spin_lock", file: !95, line: 3548, size: 32, elements: !96)
!95 = !DIFile(filename: "./linux/include/uapi/linux/bpf.h", directory: "/home/leif/stage/bmc-cache/bmc2")
!96 = !{!97}
!97 = !DIDerivedType(tag: DW_TAG_member, name: "val", scope: !94, file: !95, line: 3549, baseType: !30, size: 32)
!98 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !90, file: !91, line: 42, baseType: !31, size: 32, offset: 32)
!99 = !DIDerivedType(tag: DW_TAG_member, name: "valid", scope: !90, file: !91, line: 43, baseType: !47, size: 8, offset: 64)
!100 = !DIDerivedType(tag: DW_TAG_member, name: "hash", scope: !90, file: !91, line: 44, baseType: !31, size: 32, offset: 96)
!101 = !DIDerivedType(tag: DW_TAG_member, name: "challenger", scope: !90, file: !91, line: 45, baseType: !31, size: 32, offset: 128)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !90, file: !91, line: 46, baseType: !103, size: 3224, offset: 160)
!103 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, size: 3224, elements: !104)
!104 = !{!105}
!105 = !DISubrange(count: 403)
!106 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !79, file: !3, line: 65, baseType: !107, size: 64, offset: 192)
!107 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !108, size: 64)
!108 = !DICompositeType(tag: DW_TAG_array_type, baseType: !50, size: 88888864, elements: !109)
!109 = !{!110}
!110 = !DISubrange(count: 2777777)
!111 = !DIGlobalVariableExpression(var: !112, expr: !DIExpression())
!112 = distinct !DIGlobalVariable(name: "map_keys", scope: !2, file: !3, line: 81, type: !113, isLocal: false, isDefinition: true)
!113 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 76, size: 256, elements: !114)
!114 = !{!115, !120, !122, !132}
!115 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !113, file: !3, line: 77, baseType: !116, size: 64)
!116 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !117, size: 64)
!117 = !DICompositeType(tag: DW_TAG_array_type, baseType: !50, size: 192, elements: !118)
!118 = !{!119}
!119 = !DISubrange(count: 6)
!120 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !113, file: !3, line: 78, baseType: !121, size: 64, offset: 64)
!121 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !31, size: 64)
!122 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !113, file: !3, line: 79, baseType: !123, size: 64, offset: 128)
!123 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !124, size: 64)
!124 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "memcached_key", file: !3, line: 70, size: 2080, elements: !125)
!125 = !{!126, !127, !131}
!126 = !DIDerivedType(tag: DW_TAG_member, name: "hash", scope: !124, file: !3, line: 71, baseType: !51, size: 32)
!127 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !124, file: !3, line: 72, baseType: !128, size: 2000, offset: 32)
!128 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, size: 2000, elements: !129)
!129 = !{!130}
!130 = !DISubrange(count: 250)
!131 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !124, file: !3, line: 73, baseType: !31, size: 32, offset: 2048)
!132 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !113, file: !3, line: 80, baseType: !133, size: 64, offset: 192)
!133 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !134, size: 64)
!134 = !DICompositeType(tag: DW_TAG_array_type, baseType: !50, size: 992, elements: !135)
!135 = !{!136}
!136 = !DISubrange(count: 31)
!137 = !DIGlobalVariableExpression(var: !138, expr: !DIExpression())
!138 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !59, line: 23, type: !139, isLocal: true, isDefinition: true)
!139 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !140, size: 64)
!140 = !DISubroutineType(types: !141)
!141 = !{!6, !6, !142}
!142 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !143, size: 64)
!143 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!144 = !DIGlobalVariableExpression(var: !145, expr: !DIExpression())
!145 = distinct !DIGlobalVariable(name: "bpf_xdp_adjust_head", scope: !2, file: !59, line: 82, type: !146, isLocal: true, isDefinition: true)
!146 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !147, size: 64)
!147 = !DISubroutineType(types: !148)
!148 = !{!50, !6, !50}
!149 = !DIGlobalVariableExpression(var: !150, expr: !DIExpression())
!150 = distinct !DIGlobalVariable(name: "bpf_tail_call", scope: !2, file: !59, line: 43, type: !151, isLocal: true, isDefinition: true)
!151 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !152, size: 64)
!152 = !DISubroutineType(types: !153)
!153 = !{null, !6, !6, !50}
!154 = !DIGlobalVariableExpression(var: !155, expr: !DIExpression())
!155 = distinct !DIGlobalVariable(name: "bpf_spin_lock", scope: !2, file: !59, line: 191, type: !156, isLocal: true, isDefinition: true)
!156 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !157, size: 64)
!157 = !DISubroutineType(types: !158)
!158 = !{null, !159}
!159 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !94, size: 64)
!160 = !DIGlobalVariableExpression(var: !161, expr: !DIExpression())
!161 = distinct !DIGlobalVariable(name: "bpf_spin_unlock", scope: !2, file: !59, line: 193, type: !156, isLocal: true, isDefinition: true)
!162 = !DIGlobalVariableExpression(var: !163, expr: !DIExpression())
!163 = distinct !DIGlobalVariable(name: "bpf_xdp_adjust_tail", scope: !2, file: !59, line: 131, type: !146, isLocal: true, isDefinition: true)
!164 = !DIGlobalVariableExpression(var: !165, expr: !DIExpression())
!165 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !59, line: 41, type: !166, isLocal: true, isDefinition: true)
!166 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !167, size: 64)
!167 = !DISubroutineType(types: !168)
!168 = !{!50, !169, !50, null}
!169 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !170, size: 64)
!170 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !47)
!171 = !{i32 2, !"Dwarf Version", i32 4}
!172 = !{i32 2, !"Debug Info Version", i32 3}
!173 = !{i32 1, !"wchar_size", i32 4}
!174 = !{!"clang version 9.0.1-12 "}
!175 = distinct !DISubprogram(name: "xdp_memcached_rx_main", scope: !3, file: !3, line: 136, type: !176, scopeLine: 137, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !186)
!176 = !DISubroutineType(types: !177)
!177 = !{!50, !178}
!178 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !179, size: 64)
!179 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !95, line: 3123, size: 160, elements: !180)
!180 = !{!181, !182, !183, !184, !185}
!181 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !179, file: !95, line: 3124, baseType: !30, size: 32)
!182 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !179, file: !95, line: 3125, baseType: !30, size: 32, offset: 32)
!183 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !179, file: !95, line: 3126, baseType: !30, size: 32, offset: 64)
!184 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !179, file: !95, line: 3128, baseType: !30, size: 32, offset: 96)
!185 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !179, file: !95, line: 3129, baseType: !30, size: 32, offset: 128)
!186 = !{!187, !188, !189, !190, !200, !217, !218, !219, !220, !221, !222, !227, !243, !251}
!187 = !DILocalVariable(name: "ctx", arg: 1, scope: !175, file: !3, line: 136, type: !178)
!188 = !DILocalVariable(name: "data_end", scope: !175, file: !3, line: 138, type: !6)
!189 = !DILocalVariable(name: "data", scope: !175, file: !3, line: 139, type: !6)
!190 = !DILocalVariable(name: "eth", scope: !175, file: !3, line: 140, type: !191)
!191 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !192, size: 64)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !193, line: 163, size: 112, elements: !194)
!193 = !DIFile(filename: "./linux/include/uapi/linux/if_ether.h", directory: "/home/leif/stage/bmc-cache/bmc2")
!194 = !{!195, !198, !199}
!195 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !192, file: !193, line: 164, baseType: !196, size: 48)
!196 = !DICompositeType(tag: DW_TAG_array_type, baseType: !197, size: 48, elements: !118)
!197 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!198 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !192, file: !193, line: 165, baseType: !196, size: 48, offset: 48)
!199 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !192, file: !193, line: 166, baseType: !13, size: 16, offset: 96)
!200 = !DILocalVariable(name: "ip", scope: !175, file: !3, line: 141, type: !201)
!201 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !202, size: 64)
!202 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !203, line: 86, size: 160, elements: !204)
!203 = !DIFile(filename: "./linux/include/uapi/linux/ip.h", directory: "/home/leif/stage/bmc-cache/bmc2")
!204 = !{!205, !207, !208, !209, !210, !211, !212, !213, !214, !215, !216}
!205 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !202, file: !203, line: 88, baseType: !206, size: 4, flags: DIFlagBitField, extraData: i64 0)
!206 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !16, line: 21, baseType: !197)
!207 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !202, file: !203, line: 89, baseType: !206, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!208 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !202, file: !203, line: 96, baseType: !206, size: 8, offset: 8)
!209 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !202, file: !203, line: 97, baseType: !13, size: 16, offset: 16)
!210 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !202, file: !203, line: 98, baseType: !13, size: 16, offset: 32)
!211 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !202, file: !203, line: 99, baseType: !13, size: 16, offset: 48)
!212 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !202, file: !203, line: 100, baseType: !206, size: 8, offset: 64)
!213 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !202, file: !203, line: 101, baseType: !206, size: 8, offset: 72)
!214 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !202, file: !203, line: 102, baseType: !21, size: 16, offset: 80)
!215 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !202, file: !203, line: 103, baseType: !29, size: 32, offset: 96)
!216 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !202, file: !203, line: 104, baseType: !29, size: 32, offset: 128)
!217 = !DILocalVariable(name: "transp", scope: !175, file: !3, line: 142, type: !6)
!218 = !DILocalVariable(name: "udp", scope: !175, file: !3, line: 143, type: !8)
!219 = !DILocalVariable(name: "tcp", scope: !175, file: !3, line: 144, type: !22)
!220 = !DILocalVariable(name: "payload", scope: !175, file: !3, line: 145, type: !46)
!221 = !DILocalVariable(name: "dport", scope: !175, file: !3, line: 146, type: !13)
!222 = !DILocalVariable(name: "zero", scope: !223, file: !3, line: 172, type: !31)
!223 = distinct !DILexicalBlock(scope: !224, file: !3, line: 171, column: 120)
!224 = distinct !DILexicalBlock(scope: !225, file: !3, line: 171, column: 7)
!225 = distinct !DILexicalBlock(scope: !226, file: !3, line: 169, column: 54)
!226 = distinct !DILexicalBlock(scope: !175, file: !3, line: 169, column: 6)
!227 = !DILocalVariable(name: "stats", scope: !223, file: !3, line: 173, type: !228)
!228 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !229, size: 64)
!229 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "memcached_bpf_stats", file: !91, line: 49, size: 384, elements: !230)
!230 = !{!231, !232, !233, !234, !235, !236, !237, !238, !239, !240, !241, !242}
!231 = !DIDerivedType(tag: DW_TAG_member, name: "get_recv_count", scope: !229, file: !91, line: 50, baseType: !31, size: 32)
!232 = !DIDerivedType(tag: DW_TAG_member, name: "set_recv_count", scope: !229, file: !91, line: 51, baseType: !31, size: 32, offset: 32)
!233 = !DIDerivedType(tag: DW_TAG_member, name: "get_resp_count", scope: !229, file: !91, line: 52, baseType: !31, size: 32, offset: 64)
!234 = !DIDerivedType(tag: DW_TAG_member, name: "hit_misprediction", scope: !229, file: !91, line: 53, baseType: !31, size: 32, offset: 96)
!235 = !DIDerivedType(tag: DW_TAG_member, name: "hit_count", scope: !229, file: !91, line: 54, baseType: !31, size: 32, offset: 128)
!236 = !DIDerivedType(tag: DW_TAG_member, name: "miss_count", scope: !229, file: !91, line: 55, baseType: !31, size: 32, offset: 160)
!237 = !DIDerivedType(tag: DW_TAG_member, name: "update_count", scope: !229, file: !91, line: 56, baseType: !31, size: 32, offset: 192)
!238 = !DIDerivedType(tag: DW_TAG_member, name: "invalidation_count", scope: !229, file: !91, line: 57, baseType: !31, size: 32, offset: 224)
!239 = !DIDerivedType(tag: DW_TAG_member, name: "hot_replace_hot", scope: !229, file: !91, line: 58, baseType: !31, size: 32, offset: 256)
!240 = !DIDerivedType(tag: DW_TAG_member, name: "cold_replace_cold", scope: !229, file: !91, line: 59, baseType: !31, size: 32, offset: 288)
!241 = !DIDerivedType(tag: DW_TAG_member, name: "hot_replace_cold", scope: !229, file: !91, line: 60, baseType: !31, size: 32, offset: 320)
!242 = !DIDerivedType(tag: DW_TAG_member, name: "cold_replace_hot", scope: !229, file: !91, line: 61, baseType: !31, size: 32, offset: 352)
!243 = !DILocalVariable(name: "pctx", scope: !223, file: !3, line: 179, type: !244)
!244 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !245, size: 64)
!245 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "parsing_context", file: !3, line: 84, size: 96, elements: !246)
!246 = !{!247, !248, !249, !250}
!247 = !DIDerivedType(tag: DW_TAG_member, name: "key_count", scope: !245, file: !3, line: 85, baseType: !31, size: 32)
!248 = !DIDerivedType(tag: DW_TAG_member, name: "current_key", scope: !245, file: !3, line: 86, baseType: !31, size: 32, offset: 32)
!249 = !DIDerivedType(tag: DW_TAG_member, name: "read_pkt_offset", scope: !245, file: !3, line: 87, baseType: !17, size: 16, offset: 64)
!250 = !DIDerivedType(tag: DW_TAG_member, name: "write_pkt_offset", scope: !245, file: !3, line: 88, baseType: !17, size: 16, offset: 80)
!251 = !DILocalVariable(name: "off", scope: !223, file: !3, line: 187, type: !31)
!252 = !DILocation(line: 0, scope: !175)
!253 = !DILocation(line: 138, column: 38, scope: !175)
!254 = !{!255, !256, i64 4}
!255 = !{!"xdp_md", !256, i64 0, !256, i64 4, !256, i64 8, !256, i64 12, !256, i64 16}
!256 = !{!"int", !257, i64 0}
!257 = !{!"omnipotent char", !258, i64 0}
!258 = !{!"Simple C/C++ TBAA"}
!259 = !DILocation(line: 138, column: 27, scope: !175)
!260 = !DILocation(line: 138, column: 19, scope: !175)
!261 = !DILocation(line: 139, column: 34, scope: !175)
!262 = !{!255, !256, i64 0}
!263 = !DILocation(line: 139, column: 23, scope: !175)
!264 = !DILocation(line: 139, column: 15, scope: !175)
!265 = !DILocation(line: 147, column: 9, scope: !266)
!266 = distinct !DILexicalBlock(scope: !175, file: !3, line: 147, column: 6)
!267 = !DILocation(line: 147, column: 15, scope: !266)
!268 = !DILocation(line: 147, column: 13, scope: !266)
!269 = !DILocation(line: 147, column: 6, scope: !175)
!270 = !DILocation(line: 150, column: 14, scope: !175)
!271 = !{!272, !257, i64 9}
!272 = !{!"iphdr", !257, i64 0, !257, i64 0, !257, i64 1, !273, i64 2, !273, i64 4, !273, i64 6, !257, i64 8, !257, i64 9, !273, i64 10, !256, i64 12, !256, i64 16}
!273 = !{!"short", !257, i64 0}
!274 = !DILocation(line: 150, column: 2, scope: !175)
!275 = !DILocation(line: 153, column: 12, scope: !276)
!276 = distinct !DILexicalBlock(scope: !277, file: !3, line: 153, column: 8)
!277 = distinct !DILexicalBlock(scope: !175, file: !3, line: 150, column: 24)
!278 = !DILocation(line: 153, column: 18, scope: !276)
!279 = !DILocation(line: 153, column: 16, scope: !276)
!280 = !DILocation(line: 153, column: 8, scope: !277)
!281 = !DILocation(line: 156, column: 36, scope: !277)
!282 = !DILocation(line: 157, column: 4, scope: !277)
!283 = !DILocation(line: 160, column: 12, scope: !284)
!284 = distinct !DILexicalBlock(scope: !277, file: !3, line: 160, column: 8)
!285 = !DILocation(line: 160, column: 18, scope: !284)
!286 = !DILocation(line: 160, column: 16, scope: !284)
!287 = !DILocation(line: 160, column: 8, scope: !277)
!288 = !DILocation(line: 0, scope: !277)
!289 = !{!273, !273, i64 0}
!290 = !DILocation(line: 169, column: 12, scope: !226)
!291 = !DILocation(line: 169, column: 38, scope: !226)
!292 = !DILocation(line: 169, column: 41, scope: !226)
!293 = !DILocation(line: 169, column: 28, scope: !226)
!294 = !DILocation(line: 171, column: 35, scope: !224)
!295 = !DILocation(line: 171, column: 38, scope: !224)
!296 = !{!257, !257, i64 0}
!297 = !DILocation(line: 171, column: 49, scope: !224)
!298 = !DILocation(line: 171, column: 56, scope: !224)
!299 = !DILocation(line: 171, column: 59, scope: !224)
!300 = !DILocation(line: 171, column: 70, scope: !224)
!301 = !DILocation(line: 171, column: 77, scope: !224)
!302 = !DILocation(line: 171, column: 80, scope: !224)
!303 = !DILocation(line: 171, column: 91, scope: !224)
!304 = !DILocation(line: 171, column: 98, scope: !224)
!305 = !DILocation(line: 171, column: 101, scope: !224)
!306 = !DILocation(line: 171, column: 112, scope: !224)
!307 = !DILocation(line: 171, column: 7, scope: !225)
!308 = !DILocation(line: 172, column: 4, scope: !223)
!309 = !DILocation(line: 0, scope: !223)
!310 = !DILocation(line: 172, column: 17, scope: !223)
!311 = !{!256, !256, i64 0}
!312 = !DILocation(line: 173, column: 40, scope: !223)
!313 = !DILocation(line: 174, column: 9, scope: !314)
!314 = distinct !DILexicalBlock(scope: !223, file: !3, line: 174, column: 8)
!315 = !DILocation(line: 174, column: 8, scope: !223)
!316 = !DILocation(line: 177, column: 11, scope: !223)
!317 = !DILocation(line: 177, column: 25, scope: !223)
!318 = !{!319, !256, i64 0}
!319 = !{!"memcached_bpf_stats", !256, i64 0, !256, i64 4, !256, i64 8, !256, i64 12, !256, i64 16, !256, i64 20, !256, i64 24, !256, i64 28, !256, i64 32, !256, i64 36, !256, i64 40, !256, i64 44}
!320 = !DILocation(line: 179, column: 35, scope: !223)
!321 = !DILocation(line: 180, column: 9, scope: !322)
!322 = distinct !DILexicalBlock(scope: !223, file: !3, line: 180, column: 8)
!323 = !DILocation(line: 180, column: 8, scope: !223)
!324 = !DILocation(line: 183, column: 10, scope: !223)
!325 = !DILocation(line: 183, column: 20, scope: !223)
!326 = !{!327, !256, i64 0}
!327 = !{!"parsing_context", !256, i64 0, !256, i64 4, !273, i64 8, !273, i64 10}
!328 = !DILocation(line: 184, column: 10, scope: !223)
!329 = !DILocation(line: 184, column: 22, scope: !223)
!330 = !{!327, !256, i64 4}
!331 = !DILocation(line: 185, column: 10, scope: !223)
!332 = !DILocation(line: 185, column: 27, scope: !223)
!333 = !{!327, !273, i64 10}
!334 = !DILocation(line: 189, column: 42, scope: !335)
!335 = distinct !DILexicalBlock(scope: !336, file: !3, line: 189, column: 4)
!336 = distinct !DILexicalBlock(scope: !223, file: !3, line: 189, column: 4)
!337 = !DILocation(line: 189, column: 52, scope: !335)
!338 = !DILocation(line: 189, column: 56, scope: !335)
!339 = !DILocation(line: 189, column: 59, scope: !335)
!340 = !DILocation(line: 189, column: 71, scope: !335)
!341 = !DILocation(line: 189, column: 74, scope: !335)
!342 = !DILocation(line: 189, column: 87, scope: !335)
!343 = !DILocation(line: 189, column: 4, scope: !336)
!344 = !DILocation(line: 189, column: 98, scope: !335)
!345 = !DILocation(line: 189, column: 22, scope: !335)
!346 = distinct !{!346, !343, !347, !348}
!347 = !DILocation(line: 189, column: 103, scope: !336)
!348 = !{!"llvm.loop.unroll.disable"}
!349 = !DILocation(line: 191, column: 29, scope: !350)
!350 = distinct !DILexicalBlock(scope: !351, file: !3, line: 190, column: 33)
!351 = distinct !DILexicalBlock(scope: !223, file: !3, line: 190, column: 8)
!352 = !DILocation(line: 191, column: 11, scope: !350)
!353 = !DILocation(line: 191, column: 27, scope: !350)
!354 = !{!327, !273, i64 8}
!355 = !DILocation(line: 192, column: 29, scope: !356)
!356 = distinct !DILexicalBlock(scope: !350, file: !3, line: 192, column: 9)
!357 = !DILocation(line: 192, column: 114, scope: !356)
!358 = !DILocation(line: 192, column: 9, scope: !356)
!359 = !DILocation(line: 192, column: 9, scope: !350)
!360 = !DILocation(line: 194, column: 5, scope: !350)
!361 = !DILocation(line: 195, column: 4, scope: !350)
!362 = !DILocation(line: 196, column: 3, scope: !224)
!363 = !DILocation(line: 198, column: 18, scope: !364)
!364 = distinct !DILexicalBlock(scope: !365, file: !3, line: 197, column: 41)
!365 = distinct !DILexicalBlock(scope: !224, file: !3, line: 197, column: 12)
!366 = !DILocation(line: 198, column: 4, scope: !364)
!367 = !DILocation(line: 199, column: 3, scope: !364)
!368 = !DILocation(line: 203, column: 1, scope: !175)
!369 = distinct !DISubprogram(name: "xdp_memcached_rx_get_parse_main", scope: !3, file: !3, line: 207, type: !176, scopeLine: 208, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !370)
!370 = !{!371, !372, !373, !374, !375, !376, !377, !378, !379, !380, !381, !382, !383, !386}
!371 = !DILocalVariable(name: "ctx", arg: 1, scope: !369, file: !3, line: 207, type: !178)
!372 = !DILocalVariable(name: "data_end", scope: !369, file: !3, line: 209, type: !6)
!373 = !DILocalVariable(name: "data", scope: !369, file: !3, line: 210, type: !6)
!374 = !DILocalVariable(name: "payload", scope: !369, file: !3, line: 211, type: !46)
!375 = !DILocalVariable(name: "zero", scope: !369, file: !3, line: 212, type: !31)
!376 = !DILocalVariable(name: "pctx", scope: !369, file: !3, line: 217, type: !244)
!377 = !DILocalVariable(name: "key", scope: !369, file: !3, line: 222, type: !123)
!378 = !DILocalVariable(name: "off", scope: !369, file: !3, line: 228, type: !31)
!379 = !DILocalVariable(name: "done_parsing", scope: !369, file: !3, line: 228, type: !31)
!380 = !DILocalVariable(name: "key_len", scope: !369, file: !3, line: 228, type: !31)
!381 = !DILocalVariable(name: "cache_idx", scope: !369, file: !3, line: 252, type: !51)
!382 = !DILocalVariable(name: "entry", scope: !369, file: !3, line: 253, type: !89)
!383 = !DILocalVariable(name: "i", scope: !384, file: !3, line: 261, type: !31)
!384 = distinct !DILexicalBlock(scope: !385, file: !3, line: 259, column: 48)
!385 = distinct !DILexicalBlock(scope: !369, file: !3, line: 259, column: 6)
!386 = !DILocalVariable(name: "stats", scope: !387, file: !3, line: 270, type: !228)
!387 = distinct !DILexicalBlock(scope: !385, file: !3, line: 268, column: 9)
!388 = !DILocation(line: 0, scope: !369)
!389 = !DILocation(line: 209, column: 38, scope: !369)
!390 = !DILocation(line: 209, column: 27, scope: !369)
!391 = !DILocation(line: 209, column: 19, scope: !369)
!392 = !DILocation(line: 210, column: 34, scope: !369)
!393 = !DILocation(line: 210, column: 23, scope: !369)
!394 = !DILocation(line: 210, column: 15, scope: !369)
!395 = !DILocation(line: 212, column: 2, scope: !369)
!396 = !DILocation(line: 212, column: 15, scope: !369)
!397 = !DILocation(line: 214, column: 14, scope: !398)
!398 = distinct !DILexicalBlock(scope: !369, file: !3, line: 214, column: 6)
!399 = !DILocation(line: 214, column: 6, scope: !369)
!400 = !DILocation(line: 217, column: 33, scope: !369)
!401 = !DILocation(line: 218, column: 7, scope: !402)
!402 = distinct !DILexicalBlock(scope: !369, file: !3, line: 218, column: 6)
!403 = !DILocation(line: 218, column: 6, scope: !369)
!404 = !DILocation(line: 222, column: 68, scope: !369)
!405 = !DILocation(line: 222, column: 30, scope: !369)
!406 = !DILocation(line: 223, column: 7, scope: !407)
!407 = distinct !DILexicalBlock(scope: !369, file: !3, line: 223, column: 6)
!408 = !DILocation(line: 223, column: 6, scope: !369)
!409 = !DILocation(line: 226, column: 7, scope: !369)
!410 = !DILocation(line: 226, column: 12, scope: !369)
!411 = !{!412, !256, i64 0}
!412 = !{!"memcached_key", !256, i64 0, !257, i64 4, !256, i64 256}
!413 = !DILocation(line: 232, column: 39, scope: !414)
!414 = distinct !DILexicalBlock(scope: !415, file: !3, line: 232, column: 2)
!415 = distinct !DILexicalBlock(scope: !369, file: !3, line: 232, column: 2)
!416 = !DILocation(line: 232, column: 49, scope: !414)
!417 = !DILocation(line: 232, column: 53, scope: !414)
!418 = !DILocation(line: 232, column: 56, scope: !414)
!419 = !DILocation(line: 232, column: 2, scope: !415)
!420 = !DILocation(line: 233, column: 7, scope: !421)
!421 = distinct !DILexicalBlock(scope: !422, file: !3, line: 233, column: 7)
!422 = distinct !DILexicalBlock(scope: !414, file: !3, line: 232, column: 76)
!423 = !DILocation(line: 233, column: 7, scope: !422)
!424 = !DILocation(line: 241, column: 14, scope: !425)
!425 = distinct !DILexicalBlock(scope: !426, file: !3, line: 240, column: 33)
!426 = distinct !DILexicalBlock(scope: !427, file: !3, line: 240, column: 12)
!427 = distinct !DILexicalBlock(scope: !421, file: !3, line: 237, column: 12)
!428 = !DILocation(line: 242, column: 14, scope: !425)
!429 = !DILocation(line: 243, column: 11, scope: !425)
!430 = !DILocation(line: 232, column: 72, scope: !414)
!431 = !DILocation(line: 232, column: 20, scope: !414)
!432 = distinct !{!432, !419, !433, !348}
!433 = !DILocation(line: 245, column: 2, scope: !415)
!434 = !DILocation(line: 247, column: 19, scope: !435)
!435 = distinct !DILexicalBlock(scope: !369, file: !3, line: 247, column: 6)
!436 = !DILocation(line: 248, column: 23, scope: !437)
!437 = distinct !DILexicalBlock(scope: !435, file: !3, line: 247, column: 48)
!438 = !DILocation(line: 248, column: 148, scope: !437)
!439 = !DILocation(line: 248, column: 142, scope: !437)
!440 = !DILocation(line: 248, column: 30, scope: !437)
!441 = !DILocation(line: 248, column: 3, scope: !437)
!442 = !DILocation(line: 249, column: 3, scope: !437)
!443 = !DILocation(line: 252, column: 2, scope: !369)
!444 = !DILocation(line: 252, column: 28, scope: !369)
!445 = !DILocation(line: 252, column: 6, scope: !369)
!446 = !DILocation(line: 253, column: 40, scope: !369)
!447 = !DILocation(line: 254, column: 7, scope: !448)
!448 = distinct !DILexicalBlock(scope: !369, file: !3, line: 254, column: 6)
!449 = !DILocation(line: 254, column: 6, scope: !369)
!450 = !DILocation(line: 258, column: 24, scope: !369)
!451 = !DILocation(line: 258, column: 2, scope: !369)
!452 = !DILocation(line: 259, column: 13, scope: !385)
!453 = !{!454, !257, i64 8}
!454 = !{!"memcached_cache_entry", !455, i64 0, !256, i64 4, !257, i64 8, !256, i64 12, !256, i64 16, !257, i64 20}
!455 = !{!"bpf_spin_lock", !256, i64 0}
!456 = !DILocation(line: 259, column: 6, scope: !385)
!457 = !DILocation(line: 259, column: 19, scope: !385)
!458 = !DILocation(line: 259, column: 29, scope: !385)
!459 = !{!454, !256, i64 12}
!460 = !DILocation(line: 259, column: 42, scope: !385)
!461 = !DILocation(line: 259, column: 34, scope: !385)
!462 = !DILocation(line: 259, column: 6, scope: !369)
!463 = !DILocation(line: 260, column: 3, scope: !384)
!464 = !DILocation(line: 0, scope: !384)
!465 = !DILocation(line: 0, scope: !466)
!466 = distinct !DILexicalBlock(scope: !467, file: !3, line: 263, column: 55)
!467 = distinct !DILexicalBlock(scope: !468, file: !3, line: 263, column: 3)
!468 = distinct !DILexicalBlock(scope: !384, file: !3, line: 263, column: 3)
!469 = !DILocation(line: 263, column: 12, scope: !467)
!470 = !DILocation(line: 263, column: 22, scope: !467)
!471 = !DILocation(line: 263, column: 32, scope: !467)
!472 = !DILocation(line: 263, column: 34, scope: !467)
!473 = !DILocation(line: 263, column: 37, scope: !467)
!474 = !DILocation(line: 263, column: 3, scope: !468)
!475 = !DILocation(line: 264, column: 19, scope: !466)
!476 = !DILocation(line: 264, column: 4, scope: !466)
!477 = !DILocation(line: 264, column: 17, scope: !466)
!478 = !DILocation(line: 263, column: 51, scope: !467)
!479 = distinct !{!479, !474, !480, !348}
!480 = !DILocation(line: 265, column: 3, scope: !468)
!481 = !DILocation(line: 266, column: 8, scope: !384)
!482 = !DILocation(line: 266, column: 12, scope: !384)
!483 = !{!412, !256, i64 256}
!484 = !DILocation(line: 268, column: 2, scope: !384)
!485 = !DILocation(line: 269, column: 3, scope: !387)
!486 = !DILocation(line: 270, column: 39, scope: !387)
!487 = !DILocation(line: 0, scope: !387)
!488 = !DILocation(line: 271, column: 8, scope: !489)
!489 = distinct !DILexicalBlock(scope: !387, file: !3, line: 271, column: 7)
!490 = !DILocation(line: 271, column: 7, scope: !387)
!491 = !DILocation(line: 274, column: 10, scope: !387)
!492 = !DILocation(line: 0, scope: !385)
!493 = !DILocation(line: 277, column: 6, scope: !494)
!494 = distinct !DILexicalBlock(scope: !369, file: !3, line: 277, column: 6)
!495 = !DILocation(line: 277, column: 6, scope: !369)
!496 = !DILocation(line: 278, column: 23, scope: !497)
!497 = distinct !DILexicalBlock(scope: !494, file: !3, line: 277, column: 20)
!498 = !DILocation(line: 278, column: 148, scope: !497)
!499 = !DILocation(line: 278, column: 142, scope: !497)
!500 = !DILocation(line: 278, column: 30, scope: !497)
!501 = !DILocation(line: 278, column: 3, scope: !497)
!502 = !DILocation(line: 279, column: 13, scope: !503)
!503 = distinct !DILexicalBlock(scope: !497, file: !3, line: 279, column: 7)
!504 = !DILocation(line: 279, column: 23, scope: !503)
!505 = !DILocation(line: 279, column: 7, scope: !497)
!506 = !DILocation(line: 280, column: 4, scope: !507)
!507 = distinct !DILexicalBlock(scope: !503, file: !3, line: 279, column: 28)
!508 = !DILocation(line: 281, column: 3, scope: !507)
!509 = !DILocation(line: 283, column: 6, scope: !510)
!510 = distinct !DILexicalBlock(scope: !494, file: !3, line: 282, column: 9)
!511 = !DILocation(line: 284, column: 9, scope: !510)
!512 = !DILocation(line: 284, column: 25, scope: !510)
!513 = !DILocation(line: 285, column: 27, scope: !514)
!514 = distinct !DILexicalBlock(scope: !510, file: !3, line: 285, column: 7)
!515 = !DILocation(line: 285, column: 7, scope: !514)
!516 = !DILocation(line: 285, column: 7, scope: !510)
!517 = !DILocation(line: 287, column: 3, scope: !510)
!518 = !DILocation(line: 291, column: 1, scope: !369)
!519 = distinct !DISubprogram(name: "xdp_memcached_rx_get_adjust_pkt_main", scope: !3, file: !3, line: 294, type: !176, scopeLine: 295, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !520)
!520 = !{!521, !522, !523, !524, !525, !526, !527, !539, !540, !541, !542, !543, !544}
!521 = !DILocalVariable(name: "ctx", arg: 1, scope: !519, file: !3, line: 294, type: !178)
!522 = !DILocalVariable(name: "data_end", scope: !519, file: !3, line: 299, type: !6)
!523 = !DILocalVariable(name: "data", scope: !519, file: !3, line: 300, type: !6)
!524 = !DILocalVariable(name: "eth", scope: !519, file: !3, line: 301, type: !191)
!525 = !DILocalVariable(name: "ip", scope: !519, file: !3, line: 302, type: !201)
!526 = !DILocalVariable(name: "udp", scope: !519, file: !3, line: 303, type: !8)
!527 = !DILocalVariable(name: "memcached_udp_hdr", scope: !519, file: !3, line: 304, type: !528)
!528 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !529, size: 64)
!529 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "memcached_udp_header", file: !3, line: 47, size: 64, elements: !530)
!530 = !{!531, !532, !533, !534, !535}
!531 = !DIDerivedType(tag: DW_TAG_member, name: "request_id", scope: !529, file: !3, line: 48, baseType: !13, size: 16)
!532 = !DIDerivedType(tag: DW_TAG_member, name: "seq_num", scope: !529, file: !3, line: 49, baseType: !13, size: 16, offset: 16)
!533 = !DIDerivedType(tag: DW_TAG_member, name: "num_dgram", scope: !529, file: !3, line: 50, baseType: !13, size: 16, offset: 32)
!534 = !DIDerivedType(tag: DW_TAG_member, name: "unused", scope: !529, file: !3, line: 51, baseType: !13, size: 16, offset: 48)
!535 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !529, file: !3, line: 52, baseType: !536, offset: 64)
!536 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, elements: !537)
!537 = !{!538}
!538 = !DISubrange(count: -1)
!539 = !DILocalVariable(name: "payload", scope: !519, file: !3, line: 305, type: !46)
!540 = !DILocalVariable(name: "old_data", scope: !519, file: !3, line: 306, type: !6)
!541 = !DILocalVariable(name: "old_payload", scope: !519, file: !3, line: 307, type: !46)
!542 = !DILocalVariable(name: "tmp_mac", scope: !519, file: !3, line: 315, type: !196)
!543 = !DILocalVariable(name: "tmp_ip", scope: !519, file: !3, line: 316, type: !29)
!544 = !DILocalVariable(name: "tmp_port", scope: !519, file: !3, line: 317, type: !13)
!545 = !DILocation(line: 0, scope: !519)
!546 = !DILocation(line: 296, column: 26, scope: !547)
!547 = distinct !DILexicalBlock(scope: !519, file: !3, line: 296, column: 6)
!548 = !DILocation(line: 296, column: 6, scope: !547)
!549 = !DILocation(line: 296, column: 6, scope: !519)
!550 = !DILocation(line: 299, column: 38, scope: !519)
!551 = !DILocation(line: 299, column: 27, scope: !519)
!552 = !DILocation(line: 299, column: 19, scope: !519)
!553 = !DILocation(line: 300, column: 34, scope: !519)
!554 = !DILocation(line: 300, column: 23, scope: !519)
!555 = !DILocation(line: 300, column: 15, scope: !519)
!556 = !DILocation(line: 301, column: 23, scope: !519)
!557 = !DILocation(line: 305, column: 46, scope: !519)
!558 = !DILocation(line: 309, column: 14, scope: !559)
!559 = distinct !DILexicalBlock(scope: !519, file: !3, line: 309, column: 6)
!560 = !DILocation(line: 309, column: 40, scope: !559)
!561 = !DILocation(line: 309, column: 43, scope: !559)
!562 = !DILocation(line: 309, column: 26, scope: !559)
!563 = !DILocation(line: 306, column: 24, scope: !519)
!564 = !DILocation(line: 303, column: 43, scope: !519)
!565 = !DILocation(line: 313, column: 2, scope: !519)
!566 = !DILocation(line: 315, column: 2, scope: !519)
!567 = !DILocation(line: 315, column: 16, scope: !519)
!568 = !DILocation(line: 319, column: 2, scope: !519)
!569 = !DILocation(line: 320, column: 2, scope: !519)
!570 = !DILocation(line: 321, column: 2, scope: !519)
!571 = !DILocation(line: 323, column: 15, scope: !519)
!572 = !{!272, !256, i64 12}
!573 = !DILocation(line: 324, column: 18, scope: !519)
!574 = !{!272, !256, i64 16}
!575 = !DILocation(line: 324, column: 12, scope: !519)
!576 = !DILocation(line: 325, column: 12, scope: !519)
!577 = !DILocation(line: 327, column: 18, scope: !519)
!578 = !{!579, !273, i64 0}
!579 = !{!"udphdr", !273, i64 0, !273, i64 2, !273, i64 4, !273, i64 6}
!580 = !DILocation(line: 328, column: 21, scope: !519)
!581 = !{!579, !273, i64 2}
!582 = !DILocation(line: 328, column: 14, scope: !519)
!583 = !DILocation(line: 329, column: 12, scope: !519)
!584 = !DILocation(line: 331, column: 6, scope: !585)
!585 = distinct !DILexicalBlock(scope: !519, file: !3, line: 331, column: 6)
!586 = !DILocation(line: 331, column: 6, scope: !519)
!587 = !DILocation(line: 334, column: 2, scope: !519)
!588 = !DILocation(line: 336, column: 2, scope: !519)
!589 = !DILocation(line: 337, column: 1, scope: !519)
!590 = distinct !DISubprogram(name: "xdp_memcached_rx_get_write_pkt_main", scope: !3, file: !3, line: 340, type: !176, scopeLine: 341, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !591)
!591 = !{!592, !593, !594, !595, !596, !597, !598, !599, !600, !601, !602, !603, !607, !610, !611, !616, !617, !618}
!592 = !DILocalVariable(name: "ctx", arg: 1, scope: !590, file: !3, line: 340, type: !178)
!593 = !DILocalVariable(name: "data_end", scope: !590, file: !3, line: 342, type: !6)
!594 = !DILocalVariable(name: "data", scope: !590, file: !3, line: 343, type: !6)
!595 = !DILocalVariable(name: "payload", scope: !590, file: !3, line: 344, type: !46)
!596 = !DILocalVariable(name: "zero", scope: !590, file: !3, line: 345, type: !31)
!597 = !DILocalVariable(name: "pctx", scope: !590, file: !3, line: 350, type: !244)
!598 = !DILocalVariable(name: "key", scope: !590, file: !3, line: 355, type: !123)
!599 = !DILocalVariable(name: "cache_hit", scope: !590, file: !3, line: 360, type: !31)
!600 = !DILocalVariable(name: "written", scope: !590, file: !3, line: 360, type: !31)
!601 = !DILocalVariable(name: "cache_idx", scope: !590, file: !3, line: 361, type: !51)
!602 = !DILocalVariable(name: "entry", scope: !590, file: !3, line: 362, type: !89)
!603 = !DILocalVariable(name: "i", scope: !604, file: !3, line: 370, type: !50)
!604 = distinct !DILexicalBlock(scope: !605, file: !3, line: 370, column: 3)
!605 = distinct !DILexicalBlock(scope: !606, file: !3, line: 368, column: 48)
!606 = distinct !DILexicalBlock(scope: !590, file: !3, line: 368, column: 6)
!607 = !DILocalVariable(name: "off", scope: !608, file: !3, line: 376, type: !31)
!608 = distinct !DILexicalBlock(scope: !609, file: !3, line: 375, column: 18)
!609 = distinct !DILexicalBlock(scope: !605, file: !3, line: 375, column: 7)
!610 = !DILocalVariable(name: "stats", scope: !590, file: !3, line: 396, type: !228)
!611 = !DILocalVariable(name: "data_end", scope: !612, file: !3, line: 421, type: !6)
!612 = distinct !DILexicalBlock(scope: !613, file: !3, line: 409, column: 38)
!613 = distinct !DILexicalBlock(scope: !614, file: !3, line: 409, column: 7)
!614 = distinct !DILexicalBlock(scope: !615, file: !3, line: 408, column: 91)
!615 = distinct !DILexicalBlock(scope: !590, file: !3, line: 408, column: 6)
!616 = !DILocalVariable(name: "data", scope: !612, file: !3, line: 422, type: !6)
!617 = !DILocalVariable(name: "ip", scope: !612, file: !3, line: 423, type: !201)
!618 = !DILocalVariable(name: "udp", scope: !612, file: !3, line: 424, type: !8)
!619 = !DILocation(line: 0, scope: !590)
!620 = !DILocation(line: 342, column: 38, scope: !590)
!621 = !DILocation(line: 342, column: 27, scope: !590)
!622 = !DILocation(line: 342, column: 19, scope: !590)
!623 = !DILocation(line: 343, column: 34, scope: !590)
!624 = !DILocation(line: 343, column: 23, scope: !590)
!625 = !DILocation(line: 343, column: 15, scope: !590)
!626 = !DILocation(line: 345, column: 2, scope: !590)
!627 = !DILocation(line: 345, column: 15, scope: !590)
!628 = !DILocation(line: 347, column: 14, scope: !629)
!629 = distinct !DILexicalBlock(scope: !590, file: !3, line: 347, column: 6)
!630 = !DILocation(line: 347, column: 6, scope: !590)
!631 = !DILocation(line: 350, column: 33, scope: !590)
!632 = !DILocation(line: 351, column: 7, scope: !633)
!633 = distinct !DILexicalBlock(scope: !590, file: !3, line: 351, column: 6)
!634 = !DILocation(line: 351, column: 6, scope: !590)
!635 = !DILocation(line: 355, column: 68, scope: !590)
!636 = !DILocation(line: 355, column: 30, scope: !590)
!637 = !DILocation(line: 356, column: 7, scope: !638)
!638 = distinct !DILexicalBlock(scope: !590, file: !3, line: 356, column: 6)
!639 = !DILocation(line: 356, column: 6, scope: !590)
!640 = !DILocation(line: 361, column: 2, scope: !590)
!641 = !DILocation(line: 361, column: 23, scope: !590)
!642 = !DILocation(line: 361, column: 28, scope: !590)
!643 = !DILocation(line: 361, column: 6, scope: !590)
!644 = !DILocation(line: 362, column: 40, scope: !590)
!645 = !DILocation(line: 363, column: 7, scope: !646)
!646 = distinct !DILexicalBlock(scope: !590, file: !3, line: 363, column: 6)
!647 = !DILocation(line: 363, column: 6, scope: !590)
!648 = !DILocation(line: 367, column: 24, scope: !590)
!649 = !DILocation(line: 367, column: 2, scope: !590)
!650 = !DILocation(line: 368, column: 13, scope: !606)
!651 = !DILocation(line: 368, column: 6, scope: !606)
!652 = !DILocation(line: 368, column: 19, scope: !606)
!653 = !DILocation(line: 368, column: 27, scope: !606)
!654 = !DILocation(line: 368, column: 42, scope: !606)
!655 = !DILocation(line: 368, column: 32, scope: !606)
!656 = !DILocation(line: 368, column: 6, scope: !590)
!657 = !DILocation(line: 370, column: 50, scope: !658)
!658 = distinct !DILexicalBlock(scope: !604, file: !3, line: 370, column: 3)
!659 = !DILocation(line: 0, scope: !604)
!660 = !DILocation(line: 0, scope: !658)
!661 = !DILocation(line: 0, scope: !662)
!662 = distinct !DILexicalBlock(scope: !663, file: !3, line: 371, column: 8)
!663 = distinct !DILexicalBlock(scope: !658, file: !3, line: 370, column: 60)
!664 = !DILocation(line: 370, column: 43, scope: !658)
!665 = !DILocation(line: 370, column: 38, scope: !658)
!666 = !DILocation(line: 370, column: 3, scope: !604)
!667 = !DILocation(line: 375, column: 7, scope: !609)
!668 = !DILocation(line: 375, column: 7, scope: !605)
!669 = !DILocation(line: 378, column: 115, scope: !670)
!670 = distinct !DILexicalBlock(scope: !671, file: !3, line: 378, column: 4)
!671 = distinct !DILexicalBlock(scope: !608, file: !3, line: 378, column: 4)
!672 = !DILocation(line: 0, scope: !608)
!673 = !DILocation(line: 0, scope: !670)
!674 = !{!454, !256, i64 4}
!675 = !DILocation(line: 378, column: 71, scope: !670)
!676 = !DILocation(line: 371, column: 8, scope: !662)
!677 = !DILocation(line: 371, column: 37, scope: !662)
!678 = !DILocation(line: 371, column: 24, scope: !662)
!679 = !DILocation(line: 371, column: 21, scope: !662)
!680 = !DILocation(line: 371, column: 8, scope: !663)
!681 = !DILocation(line: 370, column: 56, scope: !658)
!682 = !DILocation(line: 370, column: 21, scope: !658)
!683 = distinct !{!683, !666, !684, !348}
!684 = !DILocation(line: 374, column: 3, scope: !604)
!685 = !DILocation(line: 378, column: 105, scope: !670)
!686 = !DILocation(line: 378, column: 119, scope: !670)
!687 = !DILocation(line: 378, column: 129, scope: !670)
!688 = !DILocation(line: 378, column: 133, scope: !670)
!689 = !DILocation(line: 378, column: 161, scope: !670)
!690 = !DILocation(line: 378, column: 4, scope: !671)
!691 = !DILocation(line: 379, column: 73, scope: !692)
!692 = distinct !DILexicalBlock(scope: !670, file: !3, line: 378, column: 181)
!693 = !DILocation(line: 379, column: 47, scope: !692)
!694 = !{!695, !695, i64 0}
!695 = !{!"long long", !257, i64 0}
!696 = !DILocation(line: 379, column: 5, scope: !692)
!697 = !DILocation(line: 379, column: 45, scope: !692)
!698 = !DILocation(line: 381, column: 13, scope: !692)
!699 = !DILocation(line: 378, column: 18, scope: !670)
!700 = !DILocation(line: 378, column: 21, scope: !670)
!701 = !DILocation(line: 378, column: 49, scope: !670)
!702 = distinct !{!702, !690, !703, !348}
!703 = !DILocation(line: 382, column: 4, scope: !671)
!704 = !DILocation(line: 0, scope: !671)
!705 = !DILocation(line: 384, column: 15, scope: !706)
!706 = distinct !DILexicalBlock(scope: !707, file: !3, line: 384, column: 4)
!707 = distinct !DILexicalBlock(scope: !608, file: !3, line: 384, column: 4)
!708 = !DILocation(line: 384, column: 37, scope: !706)
!709 = !DILocation(line: 0, scope: !706)
!710 = !DILocation(line: 384, column: 44, scope: !706)
!711 = !DILocation(line: 384, column: 71, scope: !706)
!712 = !DILocation(line: 384, column: 74, scope: !706)
!713 = !DILocation(line: 384, column: 57, scope: !706)
!714 = !DILocation(line: 385, column: 20, scope: !715)
!715 = distinct !DILexicalBlock(scope: !706, file: !3, line: 384, column: 94)
!716 = !DILocation(line: 385, column: 5, scope: !715)
!717 = !DILocation(line: 385, column: 18, scope: !715)
!718 = !DILocation(line: 386, column: 13, scope: !715)
!719 = !DILocation(line: 384, column: 90, scope: !706)
!720 = distinct !{!720, !721, !722, !348}
!721 = !DILocation(line: 384, column: 4, scope: !707)
!722 = !DILocation(line: 387, column: 4, scope: !707)
!723 = !DILocation(line: 384, column: 53, scope: !706)
!724 = !DILocation(line: 388, column: 15, scope: !725)
!725 = distinct !DILexicalBlock(scope: !608, file: !3, line: 388, column: 8)
!726 = !DILocation(line: 388, column: 21, scope: !725)
!727 = !DILocation(line: 388, column: 8, scope: !608)
!728 = !DILocation(line: 389, column: 17, scope: !729)
!729 = distinct !DILexicalBlock(scope: !725, file: !3, line: 388, column: 52)
!730 = !DILocation(line: 390, column: 4, scope: !729)
!731 = !DILocation(line: 391, column: 11, scope: !608)
!732 = !DILocation(line: 391, column: 22, scope: !608)
!733 = !{!454, !256, i64 16}
!734 = !DILocation(line: 392, column: 3, scope: !608)
!735 = !DILocation(line: 360, column: 30, scope: !590)
!736 = !DILocation(line: 360, column: 15, scope: !590)
!737 = !DILocation(line: 394, column: 2, scope: !590)
!738 = !DILocation(line: 396, column: 38, scope: !590)
!739 = !DILocation(line: 397, column: 7, scope: !740)
!740 = distinct !DILexicalBlock(scope: !590, file: !3, line: 397, column: 6)
!741 = !DILocation(line: 397, column: 6, scope: !590)
!742 = !DILocation(line: 400, column: 6, scope: !743)
!743 = distinct !DILexicalBlock(scope: !590, file: !3, line: 400, column: 6)
!744 = !DILocation(line: 400, column: 6, scope: !590)
!745 = !DILocation(line: 0, scope: !743)
!746 = !DILocation(line: 406, column: 19, scope: !590)
!747 = !DILocation(line: 408, column: 33, scope: !615)
!748 = !DILocation(line: 408, column: 24, scope: !615)
!749 = !DILocation(line: 408, column: 43, scope: !615)
!750 = !DILocation(line: 408, column: 53, scope: !615)
!751 = !DILocation(line: 408, column: 70, scope: !615)
!752 = !DILocation(line: 408, column: 85, scope: !615)
!753 = !DILocation(line: 408, column: 74, scope: !615)
!754 = !DILocation(line: 409, column: 14, scope: !613)
!755 = !DILocation(line: 409, column: 22, scope: !613)
!756 = !DILocation(line: 409, column: 25, scope: !613)
!757 = !DILocation(line: 409, column: 7, scope: !614)
!758 = !DILocation(line: 410, column: 19, scope: !612)
!759 = !DILocation(line: 410, column: 23, scope: !612)
!760 = !DILocation(line: 411, column: 19, scope: !612)
!761 = !DILocation(line: 411, column: 4, scope: !612)
!762 = !DILocation(line: 411, column: 23, scope: !612)
!763 = !DILocation(line: 412, column: 19, scope: !612)
!764 = !DILocation(line: 412, column: 4, scope: !612)
!765 = !DILocation(line: 412, column: 23, scope: !612)
!766 = !DILocation(line: 413, column: 19, scope: !612)
!767 = !DILocation(line: 413, column: 4, scope: !612)
!768 = !DILocation(line: 413, column: 23, scope: !612)
!769 = !DILocation(line: 414, column: 19, scope: !612)
!770 = !DILocation(line: 414, column: 4, scope: !612)
!771 = !DILocation(line: 414, column: 23, scope: !612)
!772 = !DILocation(line: 416, column: 28, scope: !773)
!773 = distinct !DILexicalBlock(scope: !612, file: !3, line: 416, column: 8)
!774 = !DILocation(line: 417, column: 60, scope: !773)
!775 = !DILocation(line: 417, column: 54, scope: !773)
!776 = !DILocation(line: 416, column: 35, scope: !773)
!777 = !DILocation(line: 416, column: 8, scope: !773)
!778 = !DILocation(line: 416, column: 8, scope: !612)
!779 = !DILocation(line: 421, column: 40, scope: !612)
!780 = !DILocation(line: 421, column: 29, scope: !612)
!781 = !DILocation(line: 0, scope: !612)
!782 = !DILocation(line: 422, column: 36, scope: !612)
!783 = !DILocation(line: 422, column: 25, scope: !612)
!784 = !DILocation(line: 422, column: 17, scope: !612)
!785 = !DILocation(line: 423, column: 28, scope: !612)
!786 = !DILocation(line: 427, column: 12, scope: !787)
!787 = distinct !DILexicalBlock(scope: !612, file: !3, line: 427, column: 8)
!788 = !DILocation(line: 427, column: 18, scope: !787)
!789 = !DILocation(line: 427, column: 16, scope: !787)
!790 = !DILocation(line: 427, column: 8, scope: !612)
!791 = !DILocation(line: 425, column: 72, scope: !612)
!792 = !DILocation(line: 424, column: 54, scope: !612)
!793 = !DILocation(line: 430, column: 18, scope: !612)
!794 = !DILocation(line: 430, column: 8, scope: !612)
!795 = !DILocation(line: 430, column: 16, scope: !612)
!796 = !{!272, !273, i64 2}
!797 = !DILocalVariable(name: "ip", arg: 1, scope: !798, file: !3, line: 121, type: !201)
!798 = distinct !DISubprogram(name: "compute_ip_checksum", scope: !3, file: !3, line: 121, type: !799, scopeLine: 122, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !801)
!799 = !DISubroutineType(types: !800)
!800 = !{!54, !201}
!801 = !{!797, !802, !803, !804}
!802 = !DILocalVariable(name: "csum", scope: !798, file: !3, line: 123, type: !51)
!803 = !DILocalVariable(name: "next_ip_u16", scope: !798, file: !3, line: 124, type: !53)
!804 = !DILocalVariable(name: "i", scope: !805, file: !3, line: 129, type: !50)
!805 = distinct !DILexicalBlock(scope: !798, file: !3, line: 129, column: 5)
!806 = !DILocation(line: 0, scope: !798, inlinedAt: !807)
!807 = distinct !DILocation(line: 431, column: 16, scope: !612)
!808 = !DILocation(line: 124, column: 24, scope: !798, inlinedAt: !807)
!809 = !DILocation(line: 126, column: 9, scope: !798, inlinedAt: !807)
!810 = !DILocation(line: 0, scope: !805, inlinedAt: !807)
!811 = !DILocation(line: 130, column: 17, scope: !812, inlinedAt: !807)
!812 = distinct !DILexicalBlock(scope: !805, file: !3, line: 129, column: 5)
!813 = !DILocation(line: 130, column: 29, scope: !812, inlinedAt: !807)
!814 = !DILocation(line: 130, column: 14, scope: !812, inlinedAt: !807)
!815 = !DILocation(line: 132, column: 35, scope: !798, inlinedAt: !807)
!816 = !DILocation(line: 132, column: 27, scope: !798, inlinedAt: !807)
!817 = !DILocation(line: 132, column: 9, scope: !798, inlinedAt: !807)
!818 = !DILocation(line: 431, column: 14, scope: !612)
!819 = !{!272, !273, i64 10}
!820 = !DILocation(line: 432, column: 9, scope: !612)
!821 = !DILocation(line: 432, column: 15, scope: !612)
!822 = !{!579, !273, i64 6}
!823 = !DILocation(line: 433, column: 15, scope: !612)
!824 = !DILocation(line: 433, column: 9, scope: !612)
!825 = !DILocation(line: 433, column: 13, scope: !612)
!826 = !{!579, !273, i64 4}
!827 = !DILocation(line: 435, column: 33, scope: !612)
!828 = !DILocation(line: 435, column: 31, scope: !612)
!829 = !DILocation(line: 435, column: 4, scope: !612)
!830 = !DILocation(line: 437, column: 4, scope: !612)
!831 = !DILocation(line: 440, column: 10, scope: !832)
!832 = distinct !DILexicalBlock(scope: !833, file: !3, line: 439, column: 51)
!833 = distinct !DILexicalBlock(scope: !615, file: !3, line: 439, column: 13)
!834 = !DILocation(line: 440, column: 28, scope: !832)
!835 = !{!319, !256, i64 12}
!836 = !DILocation(line: 441, column: 23, scope: !832)
!837 = !DILocation(line: 441, column: 3, scope: !832)
!838 = !DILocation(line: 442, column: 3, scope: !832)
!839 = !DILocation(line: 443, column: 31, scope: !840)
!840 = distinct !DILexicalBlock(scope: !833, file: !3, line: 443, column: 13)
!841 = !DILocation(line: 443, column: 13, scope: !833)
!842 = !DILocation(line: 444, column: 9, scope: !843)
!843 = distinct !DILexicalBlock(scope: !840, file: !3, line: 443, column: 52)
!844 = !DILocation(line: 444, column: 26, scope: !843)
!845 = !DILocation(line: 445, column: 27, scope: !846)
!846 = distinct !DILexicalBlock(scope: !843, file: !3, line: 445, column: 7)
!847 = !DILocation(line: 445, column: 7, scope: !846)
!848 = !DILocation(line: 445, column: 7, scope: !843)
!849 = !DILocation(line: 447, column: 3, scope: !843)
!850 = !DILocation(line: 448, column: 2, scope: !843)
!851 = !DILocation(line: 451, column: 1, scope: !590)
!852 = distinct !DISubprogram(name: "xdp_memcached_rx_set_parse_main", scope: !3, file: !3, line: 454, type: !176, scopeLine: 455, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !853)
!853 = !{!854, !855, !856, !857, !858, !859, !860, !861, !862, !863, !864, !865, !866, !868, !877, !878}
!854 = !DILocalVariable(name: "ctx", arg: 1, scope: !852, file: !3, line: 454, type: !178)
!855 = !DILocalVariable(name: "data_end", scope: !852, file: !3, line: 456, type: !6)
!856 = !DILocalVariable(name: "data", scope: !852, file: !3, line: 457, type: !6)
!857 = !DILocalVariable(name: "eth", scope: !852, file: !3, line: 458, type: !191)
!858 = !DILocalVariable(name: "ip", scope: !852, file: !3, line: 459, type: !201)
!859 = !DILocalVariable(name: "tcp", scope: !852, file: !3, line: 460, type: !22)
!860 = !DILocalVariable(name: "payload", scope: !852, file: !3, line: 461, type: !46)
!861 = !DILocalVariable(name: "zero", scope: !852, file: !3, line: 462, type: !31)
!862 = !DILocalVariable(name: "stats", scope: !852, file: !3, line: 467, type: !228)
!863 = !DILocalVariable(name: "hash", scope: !852, file: !3, line: 472, type: !51)
!864 = !DILocalVariable(name: "set_found", scope: !852, file: !3, line: 473, type: !50)
!865 = !DILocalVariable(name: "key_found", scope: !852, file: !3, line: 473, type: !50)
!866 = !DILocalVariable(name: "off", scope: !867, file: !3, line: 476, type: !31)
!867 = distinct !DILexicalBlock(scope: !852, file: !3, line: 476, column: 2)
!868 = !DILocalVariable(name: "cache_idx", scope: !869, file: !3, line: 496, type: !51)
!869 = distinct !DILexicalBlock(scope: !870, file: !3, line: 495, column: 29)
!870 = distinct !DILexicalBlock(scope: !871, file: !3, line: 495, column: 8)
!871 = distinct !DILexicalBlock(scope: !872, file: !3, line: 494, column: 28)
!872 = distinct !DILexicalBlock(scope: !873, file: !3, line: 494, column: 12)
!873 = distinct !DILexicalBlock(scope: !874, file: !3, line: 483, column: 12)
!874 = distinct !DILexicalBlock(scope: !875, file: !3, line: 478, column: 7)
!875 = distinct !DILexicalBlock(scope: !876, file: !3, line: 476, column: 90)
!876 = distinct !DILexicalBlock(scope: !867, file: !3, line: 476, column: 2)
!877 = !DILocalVariable(name: "entry", scope: !869, file: !3, line: 497, type: !89)
!878 = !DILocalVariable(name: "____fmt", scope: !879, file: !3, line: 521, type: !882)
!879 = distinct !DILexicalBlock(scope: !880, file: !3, line: 521, column: 3)
!880 = distinct !DILexicalBlock(scope: !881, file: !3, line: 520, column: 40)
!881 = distinct !DILexicalBlock(scope: !852, file: !3, line: 520, column: 6)
!882 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, size: 576, elements: !883)
!883 = !{!884}
!884 = !DISubrange(count: 72)
!885 = !DILocation(line: 0, scope: !852)
!886 = !DILocation(line: 456, column: 38, scope: !852)
!887 = !DILocation(line: 456, column: 27, scope: !852)
!888 = !DILocation(line: 456, column: 19, scope: !852)
!889 = !DILocation(line: 457, column: 34, scope: !852)
!890 = !DILocation(line: 457, column: 23, scope: !852)
!891 = !DILocation(line: 457, column: 15, scope: !852)
!892 = !DILocation(line: 461, column: 32, scope: !852)
!893 = !DILocation(line: 462, column: 2, scope: !852)
!894 = !DILocation(line: 462, column: 15, scope: !852)
!895 = !DILocation(line: 464, column: 14, scope: !896)
!896 = distinct !DILexicalBlock(scope: !852, file: !3, line: 464, column: 6)
!897 = !DILocation(line: 464, column: 6, scope: !852)
!898 = !DILocation(line: 467, column: 38, scope: !852)
!899 = !DILocation(line: 468, column: 7, scope: !900)
!900 = distinct !DILexicalBlock(scope: !852, file: !3, line: 468, column: 6)
!901 = !DILocation(line: 468, column: 6, scope: !852)
!902 = !DILocation(line: 0, scope: !867)
!903 = !DILocation(line: 0, scope: !904)
!904 = distinct !DILexicalBlock(scope: !874, file: !3, line: 478, column: 125)
!905 = !DILocation(line: 0, scope: !869)
!906 = !DILocation(line: 0, scope: !907)
!907 = distinct !DILexicalBlock(scope: !908, file: !3, line: 502, column: 46)
!908 = distinct !DILexicalBlock(scope: !869, file: !3, line: 502, column: 9)
!909 = !DILocation(line: 476, column: 53, scope: !876)
!910 = !DILocation(line: 476, column: 63, scope: !876)
!911 = !DILocation(line: 476, column: 67, scope: !876)
!912 = !DILocation(line: 476, column: 70, scope: !876)
!913 = !DILocation(line: 476, column: 2, scope: !867)
!914 = !DILocation(line: 478, column: 17, scope: !874)
!915 = !DILocation(line: 478, column: 22, scope: !874)
!916 = !DILocation(line: 478, column: 25, scope: !874)
!917 = !DILocation(line: 478, column: 38, scope: !874)
!918 = !DILocation(line: 478, column: 59, scope: !874)
!919 = !DILocation(line: 478, column: 62, scope: !874)
!920 = !DILocation(line: 478, column: 45, scope: !874)
!921 = !DILocation(line: 478, column: 88, scope: !874)
!922 = !DILocation(line: 478, column: 77, scope: !874)
!923 = !DILocation(line: 478, column: 92, scope: !874)
!924 = !DILocation(line: 478, column: 99, scope: !874)
!925 = !DILocation(line: 478, column: 113, scope: !874)
!926 = !DILocation(line: 478, column: 102, scope: !874)
!927 = !DILocation(line: 478, column: 117, scope: !874)
!928 = !DILocation(line: 478, column: 7, scope: !875)
!929 = !DILocation(line: 480, column: 8, scope: !904)
!930 = !DILocation(line: 481, column: 25, scope: !904)
!931 = !{!319, !256, i64 4}
!932 = !DILocation(line: 482, column: 3, scope: !904)
!933 = !DILocation(line: 483, column: 22, scope: !873)
!934 = !DILocation(line: 483, column: 40, scope: !873)
!935 = !DILocation(line: 483, column: 27, scope: !873)
!936 = !DILocation(line: 483, column: 48, scope: !873)
!937 = !DILocation(line: 483, column: 12, scope: !874)
!938 = !DILocation(line: 494, column: 12, scope: !873)
!939 = !DILocation(line: 489, column: 10, scope: !940)
!940 = distinct !DILexicalBlock(scope: !941, file: !3, line: 487, column: 11)
!941 = distinct !DILexicalBlock(scope: !942, file: !3, line: 484, column: 8)
!942 = distinct !DILexicalBlock(scope: !873, file: !3, line: 483, column: 69)
!943 = !DILocation(line: 490, column: 10, scope: !940)
!944 = !DILocation(line: 494, column: 22, scope: !872)
!945 = !DILocation(line: 495, column: 8, scope: !870)
!946 = !DILocation(line: 495, column: 21, scope: !870)
!947 = !DILocation(line: 495, column: 8, scope: !871)
!948 = !DILocation(line: 496, column: 5, scope: !869)
!949 = !DILocation(line: 496, column: 26, scope: !869)
!950 = !DILocation(line: 496, column: 9, scope: !869)
!951 = !DILocation(line: 497, column: 43, scope: !869)
!952 = !DILocation(line: 498, column: 10, scope: !953)
!953 = distinct !DILexicalBlock(scope: !869, file: !3, line: 498, column: 9)
!954 = !DILocation(line: 498, column: 9, scope: !869)
!955 = !DILocation(line: 501, column: 27, scope: !869)
!956 = !DILocation(line: 501, column: 5, scope: !869)
!957 = !DILocation(line: 502, column: 16, scope: !908)
!958 = !DILocation(line: 502, column: 9, scope: !908)
!959 = !DILocation(line: 502, column: 22, scope: !908)
!960 = !DILocation(line: 502, column: 32, scope: !908)
!961 = !DILocation(line: 502, column: 37, scope: !908)
!962 = !DILocation(line: 502, column: 9, scope: !869)
!963 = !DILocation(line: 506, column: 19, scope: !907)
!964 = !DILocation(line: 507, column: 31, scope: !907)
!965 = !{!319, !256, i64 28}
!966 = !DILocation(line: 508, column: 5, scope: !907)
!967 = !DILocation(line: 509, column: 5, scope: !869)
!968 = !DILocation(line: 512, column: 4, scope: !870)
!969 = !DILocation(line: 514, column: 10, scope: !970)
!970 = distinct !DILexicalBlock(scope: !870, file: !3, line: 513, column: 9)
!971 = !DILocation(line: 515, column: 10, scope: !970)
!972 = !DILocation(line: 476, column: 86, scope: !876)
!973 = !DILocation(line: 476, column: 33, scope: !876)
!974 = distinct !{!974, !913, !975, !348}
!975 = !DILocation(line: 518, column: 2, scope: !867)
!976 = !DILocation(line: 473, column: 21, scope: !852)
!977 = !DILocation(line: 520, column: 16, scope: !881)
!978 = !DILocation(line: 520, column: 34, scope: !881)
!979 = !DILocation(line: 520, column: 21, scope: !881)
!980 = !DILocation(line: 521, column: 3, scope: !879)
!981 = !DILocation(line: 521, column: 3, scope: !880)
!982 = !DILocation(line: 522, column: 2, scope: !880)
!983 = !DILocation(line: 525, column: 1, scope: !852)
!984 = distinct !DISubprogram(name: "tc_memcached_tx_main", scope: !3, file: !3, line: 528, type: !985, scopeLine: 529, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !1074)
!985 = !DISubroutineType(types: !986)
!986 = !{!50, !987}
!987 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !988, size: 64)
!988 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__sk_buff", file: !95, line: 2934, size: 1408, elements: !989)
!989 = !{!990, !991, !992, !993, !994, !995, !996, !997, !998, !999, !1000, !1001, !1002, !1006, !1007, !1008, !1009, !1010, !1011, !1012, !1013, !1014, !1016, !1017, !1018, !1019, !1020, !1050, !1052, !1053, !1054}
!990 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !988, file: !95, line: 2935, baseType: !30, size: 32)
!991 = !DIDerivedType(tag: DW_TAG_member, name: "pkt_type", scope: !988, file: !95, line: 2936, baseType: !30, size: 32, offset: 32)
!992 = !DIDerivedType(tag: DW_TAG_member, name: "mark", scope: !988, file: !95, line: 2937, baseType: !30, size: 32, offset: 64)
!993 = !DIDerivedType(tag: DW_TAG_member, name: "queue_mapping", scope: !988, file: !95, line: 2938, baseType: !30, size: 32, offset: 96)
!994 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !988, file: !95, line: 2939, baseType: !30, size: 32, offset: 128)
!995 = !DIDerivedType(tag: DW_TAG_member, name: "vlan_present", scope: !988, file: !95, line: 2940, baseType: !30, size: 32, offset: 160)
!996 = !DIDerivedType(tag: DW_TAG_member, name: "vlan_tci", scope: !988, file: !95, line: 2941, baseType: !30, size: 32, offset: 192)
!997 = !DIDerivedType(tag: DW_TAG_member, name: "vlan_proto", scope: !988, file: !95, line: 2942, baseType: !30, size: 32, offset: 224)
!998 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !988, file: !95, line: 2943, baseType: !30, size: 32, offset: 256)
!999 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !988, file: !95, line: 2944, baseType: !30, size: 32, offset: 288)
!1000 = !DIDerivedType(tag: DW_TAG_member, name: "ifindex", scope: !988, file: !95, line: 2945, baseType: !30, size: 32, offset: 320)
!1001 = !DIDerivedType(tag: DW_TAG_member, name: "tc_index", scope: !988, file: !95, line: 2946, baseType: !30, size: 32, offset: 352)
!1002 = !DIDerivedType(tag: DW_TAG_member, name: "cb", scope: !988, file: !95, line: 2947, baseType: !1003, size: 160, offset: 384)
!1003 = !DICompositeType(tag: DW_TAG_array_type, baseType: !30, size: 160, elements: !1004)
!1004 = !{!1005}
!1005 = !DISubrange(count: 5)
!1006 = !DIDerivedType(tag: DW_TAG_member, name: "hash", scope: !988, file: !95, line: 2948, baseType: !30, size: 32, offset: 544)
!1007 = !DIDerivedType(tag: DW_TAG_member, name: "tc_classid", scope: !988, file: !95, line: 2949, baseType: !30, size: 32, offset: 576)
!1008 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !988, file: !95, line: 2950, baseType: !30, size: 32, offset: 608)
!1009 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !988, file: !95, line: 2951, baseType: !30, size: 32, offset: 640)
!1010 = !DIDerivedType(tag: DW_TAG_member, name: "napi_id", scope: !988, file: !95, line: 2952, baseType: !30, size: 32, offset: 672)
!1011 = !DIDerivedType(tag: DW_TAG_member, name: "family", scope: !988, file: !95, line: 2955, baseType: !30, size: 32, offset: 704)
!1012 = !DIDerivedType(tag: DW_TAG_member, name: "remote_ip4", scope: !988, file: !95, line: 2956, baseType: !30, size: 32, offset: 736)
!1013 = !DIDerivedType(tag: DW_TAG_member, name: "local_ip4", scope: !988, file: !95, line: 2957, baseType: !30, size: 32, offset: 768)
!1014 = !DIDerivedType(tag: DW_TAG_member, name: "remote_ip6", scope: !988, file: !95, line: 2958, baseType: !1015, size: 128, offset: 800)
!1015 = !DICompositeType(tag: DW_TAG_array_type, baseType: !30, size: 128, elements: !75)
!1016 = !DIDerivedType(tag: DW_TAG_member, name: "local_ip6", scope: !988, file: !95, line: 2959, baseType: !1015, size: 128, offset: 928)
!1017 = !DIDerivedType(tag: DW_TAG_member, name: "remote_port", scope: !988, file: !95, line: 2960, baseType: !30, size: 32, offset: 1056)
!1018 = !DIDerivedType(tag: DW_TAG_member, name: "local_port", scope: !988, file: !95, line: 2961, baseType: !30, size: 32, offset: 1088)
!1019 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !988, file: !95, line: 2964, baseType: !30, size: 32, offset: 1120)
!1020 = !DIDerivedType(tag: DW_TAG_member, scope: !988, file: !95, line: 2965, baseType: !1021, size: 64, align: 64, offset: 1152)
!1021 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !988, file: !95, line: 2965, size: 64, align: 64, elements: !1022)
!1022 = !{!1023}
!1023 = !DIDerivedType(tag: DW_TAG_member, name: "flow_keys", scope: !1021, file: !95, line: 2965, baseType: !1024, size: 64)
!1024 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1025, size: 64)
!1025 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_flow_keys", file: !95, line: 3510, size: 384, elements: !1026)
!1026 = !{!1027, !1028, !1029, !1030, !1031, !1032, !1033, !1034, !1035, !1036, !1037}
!1027 = !DIDerivedType(tag: DW_TAG_member, name: "nhoff", scope: !1025, file: !95, line: 3511, baseType: !15, size: 16)
!1028 = !DIDerivedType(tag: DW_TAG_member, name: "thoff", scope: !1025, file: !95, line: 3512, baseType: !15, size: 16, offset: 16)
!1029 = !DIDerivedType(tag: DW_TAG_member, name: "addr_proto", scope: !1025, file: !95, line: 3513, baseType: !15, size: 16, offset: 32)
!1030 = !DIDerivedType(tag: DW_TAG_member, name: "is_frag", scope: !1025, file: !95, line: 3514, baseType: !206, size: 8, offset: 48)
!1031 = !DIDerivedType(tag: DW_TAG_member, name: "is_first_frag", scope: !1025, file: !95, line: 3515, baseType: !206, size: 8, offset: 56)
!1032 = !DIDerivedType(tag: DW_TAG_member, name: "is_encap", scope: !1025, file: !95, line: 3516, baseType: !206, size: 8, offset: 64)
!1033 = !DIDerivedType(tag: DW_TAG_member, name: "ip_proto", scope: !1025, file: !95, line: 3517, baseType: !206, size: 8, offset: 72)
!1034 = !DIDerivedType(tag: DW_TAG_member, name: "n_proto", scope: !1025, file: !95, line: 3518, baseType: !13, size: 16, offset: 80)
!1035 = !DIDerivedType(tag: DW_TAG_member, name: "sport", scope: !1025, file: !95, line: 3519, baseType: !13, size: 16, offset: 96)
!1036 = !DIDerivedType(tag: DW_TAG_member, name: "dport", scope: !1025, file: !95, line: 3520, baseType: !13, size: 16, offset: 112)
!1037 = !DIDerivedType(tag: DW_TAG_member, scope: !1025, file: !95, line: 3521, baseType: !1038, size: 256, offset: 128)
!1038 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !1025, file: !95, line: 3521, size: 256, elements: !1039)
!1039 = !{!1040, !1045}
!1040 = !DIDerivedType(tag: DW_TAG_member, scope: !1038, file: !95, line: 3522, baseType: !1041, size: 64)
!1041 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !1038, file: !95, line: 3522, size: 64, elements: !1042)
!1042 = !{!1043, !1044}
!1043 = !DIDerivedType(tag: DW_TAG_member, name: "ipv4_src", scope: !1041, file: !95, line: 3523, baseType: !29, size: 32)
!1044 = !DIDerivedType(tag: DW_TAG_member, name: "ipv4_dst", scope: !1041, file: !95, line: 3524, baseType: !29, size: 32, offset: 32)
!1045 = !DIDerivedType(tag: DW_TAG_member, scope: !1038, file: !95, line: 3526, baseType: !1046, size: 256)
!1046 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !1038, file: !95, line: 3526, size: 256, elements: !1047)
!1047 = !{!1048, !1049}
!1048 = !DIDerivedType(tag: DW_TAG_member, name: "ipv6_src", scope: !1046, file: !95, line: 3527, baseType: !1015, size: 128)
!1049 = !DIDerivedType(tag: DW_TAG_member, name: "ipv6_dst", scope: !1046, file: !95, line: 3528, baseType: !1015, size: 128, offset: 128)
!1050 = !DIDerivedType(tag: DW_TAG_member, name: "tstamp", scope: !988, file: !95, line: 2966, baseType: !1051, size: 64, offset: 1216)
!1051 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !16, line: 31, baseType: !49)
!1052 = !DIDerivedType(tag: DW_TAG_member, name: "wire_len", scope: !988, file: !95, line: 2967, baseType: !30, size: 32, offset: 1280)
!1053 = !DIDerivedType(tag: DW_TAG_member, name: "gso_segs", scope: !988, file: !95, line: 2968, baseType: !30, size: 32, offset: 1312)
!1054 = !DIDerivedType(tag: DW_TAG_member, scope: !988, file: !95, line: 2969, baseType: !1055, size: 64, align: 64, offset: 1344)
!1055 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !988, file: !95, line: 2969, size: 64, align: 64, elements: !1056)
!1056 = !{!1057}
!1057 = !DIDerivedType(tag: DW_TAG_member, name: "sk", scope: !1055, file: !95, line: 2969, baseType: !1058, size: 64)
!1058 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1059, size: 64)
!1059 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_sock", file: !95, line: 3022, size: 608, elements: !1060)
!1060 = !{!1061, !1062, !1063, !1064, !1065, !1066, !1067, !1068, !1069, !1070, !1071, !1072, !1073}
!1061 = !DIDerivedType(tag: DW_TAG_member, name: "bound_dev_if", scope: !1059, file: !95, line: 3023, baseType: !30, size: 32)
!1062 = !DIDerivedType(tag: DW_TAG_member, name: "family", scope: !1059, file: !95, line: 3024, baseType: !30, size: 32, offset: 32)
!1063 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !1059, file: !95, line: 3025, baseType: !30, size: 32, offset: 64)
!1064 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !1059, file: !95, line: 3026, baseType: !30, size: 32, offset: 96)
!1065 = !DIDerivedType(tag: DW_TAG_member, name: "mark", scope: !1059, file: !95, line: 3027, baseType: !30, size: 32, offset: 128)
!1066 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !1059, file: !95, line: 3028, baseType: !30, size: 32, offset: 160)
!1067 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip4", scope: !1059, file: !95, line: 3030, baseType: !30, size: 32, offset: 192)
!1068 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip6", scope: !1059, file: !95, line: 3031, baseType: !1015, size: 128, offset: 224)
!1069 = !DIDerivedType(tag: DW_TAG_member, name: "src_port", scope: !1059, file: !95, line: 3032, baseType: !30, size: 32, offset: 352)
!1070 = !DIDerivedType(tag: DW_TAG_member, name: "dst_port", scope: !1059, file: !95, line: 3033, baseType: !30, size: 32, offset: 384)
!1071 = !DIDerivedType(tag: DW_TAG_member, name: "dst_ip4", scope: !1059, file: !95, line: 3034, baseType: !30, size: 32, offset: 416)
!1072 = !DIDerivedType(tag: DW_TAG_member, name: "dst_ip6", scope: !1059, file: !95, line: 3035, baseType: !1015, size: 128, offset: 448)
!1073 = !DIDerivedType(tag: DW_TAG_member, name: "state", scope: !1059, file: !95, line: 3036, baseType: !30, size: 32, offset: 576)
!1074 = !{!1075, !1076, !1077, !1078, !1079, !1080, !1081, !1082, !1083, !1084}
!1075 = !DILocalVariable(name: "skb", arg: 1, scope: !984, file: !3, line: 528, type: !987)
!1076 = !DILocalVariable(name: "data_end", scope: !984, file: !3, line: 530, type: !6)
!1077 = !DILocalVariable(name: "data", scope: !984, file: !3, line: 531, type: !6)
!1078 = !DILocalVariable(name: "eth", scope: !984, file: !3, line: 532, type: !191)
!1079 = !DILocalVariable(name: "ip", scope: !984, file: !3, line: 533, type: !201)
!1080 = !DILocalVariable(name: "udp", scope: !984, file: !3, line: 534, type: !8)
!1081 = !DILocalVariable(name: "payload", scope: !984, file: !3, line: 535, type: !46)
!1082 = !DILocalVariable(name: "zero", scope: !984, file: !3, line: 536, type: !31)
!1083 = !DILocalVariable(name: "sport", scope: !984, file: !3, line: 551, type: !13)
!1084 = !DILocalVariable(name: "stats", scope: !1085, file: !3, line: 556, type: !228)
!1085 = distinct !DILexicalBlock(scope: !1086, file: !3, line: 554, column: 67)
!1086 = distinct !DILexicalBlock(scope: !984, file: !3, line: 553, column: 6)
!1087 = !DILocation(line: 0, scope: !984)
!1088 = !DILocation(line: 530, column: 38, scope: !984)
!1089 = !{!1090, !256, i64 80}
!1090 = !{!"__sk_buff", !256, i64 0, !256, i64 4, !256, i64 8, !256, i64 12, !256, i64 16, !256, i64 20, !256, i64 24, !256, i64 28, !256, i64 32, !256, i64 36, !256, i64 40, !256, i64 44, !257, i64 48, !256, i64 68, !256, i64 72, !256, i64 76, !256, i64 80, !256, i64 84, !256, i64 88, !256, i64 92, !256, i64 96, !257, i64 100, !257, i64 116, !256, i64 132, !256, i64 136, !256, i64 140, !257, i64 144, !695, i64 152, !256, i64 160, !256, i64 164, !257, i64 168}
!1091 = !DILocation(line: 530, column: 27, scope: !984)
!1092 = !DILocation(line: 530, column: 19, scope: !984)
!1093 = !DILocation(line: 531, column: 38, scope: !984)
!1094 = !{!1090, !256, i64 76}
!1095 = !DILocation(line: 531, column: 27, scope: !984)
!1096 = !DILocation(line: 531, column: 19, scope: !984)
!1097 = !DILocation(line: 534, column: 43, scope: !984)
!1098 = !DILocation(line: 535, column: 67, scope: !984)
!1099 = !DILocation(line: 536, column: 2, scope: !984)
!1100 = !DILocation(line: 536, column: 15, scope: !984)
!1101 = !DILocation(line: 539, column: 11, scope: !1102)
!1102 = distinct !DILexicalBlock(scope: !984, file: !3, line: 539, column: 6)
!1103 = !{!1090, !256, i64 0}
!1104 = !DILocation(line: 539, column: 15, scope: !1102)
!1105 = !DILocation(line: 539, column: 6, scope: !984)
!1106 = !DILocation(line: 542, column: 9, scope: !1107)
!1107 = distinct !DILexicalBlock(scope: !984, file: !3, line: 542, column: 6)
!1108 = !DILocation(line: 542, column: 15, scope: !1107)
!1109 = !DILocation(line: 542, column: 13, scope: !1107)
!1110 = !DILocation(line: 542, column: 6, scope: !984)
!1111 = !DILocation(line: 545, column: 10, scope: !1112)
!1112 = distinct !DILexicalBlock(scope: !984, file: !3, line: 545, column: 6)
!1113 = !DILocation(line: 545, column: 19, scope: !1112)
!1114 = !DILocation(line: 545, column: 6, scope: !984)
!1115 = !DILocation(line: 548, column: 10, scope: !1116)
!1116 = distinct !DILexicalBlock(scope: !984, file: !3, line: 548, column: 6)
!1117 = !DILocation(line: 548, column: 16, scope: !1116)
!1118 = !DILocation(line: 548, column: 14, scope: !1116)
!1119 = !DILocation(line: 548, column: 6, scope: !984)
!1120 = !DILocation(line: 551, column: 22, scope: !984)
!1121 = !DILocation(line: 553, column: 12, scope: !1086)
!1122 = !DILocation(line: 553, column: 28, scope: !1086)
!1123 = !DILocation(line: 553, column: 38, scope: !1086)
!1124 = !DILocation(line: 553, column: 40, scope: !1086)
!1125 = !DILocation(line: 553, column: 43, scope: !1086)
!1126 = !DILocation(line: 553, column: 55, scope: !1086)
!1127 = !DILocation(line: 553, column: 58, scope: !1086)
!1128 = !DILocation(line: 553, column: 69, scope: !1086)
!1129 = !DILocation(line: 553, column: 76, scope: !1086)
!1130 = !DILocation(line: 553, column: 79, scope: !1086)
!1131 = !DILocation(line: 553, column: 90, scope: !1086)
!1132 = !DILocation(line: 553, column: 97, scope: !1086)
!1133 = !DILocation(line: 553, column: 100, scope: !1086)
!1134 = !DILocation(line: 553, column: 111, scope: !1086)
!1135 = !DILocation(line: 554, column: 3, scope: !1086)
!1136 = !DILocation(line: 554, column: 6, scope: !1086)
!1137 = !DILocation(line: 554, column: 17, scope: !1086)
!1138 = !DILocation(line: 554, column: 24, scope: !1086)
!1139 = !DILocation(line: 554, column: 27, scope: !1086)
!1140 = !DILocation(line: 554, column: 38, scope: !1086)
!1141 = !DILocation(line: 554, column: 45, scope: !1086)
!1142 = !DILocation(line: 554, column: 48, scope: !1086)
!1143 = !DILocation(line: 554, column: 59, scope: !1086)
!1144 = !DILocation(line: 553, column: 6, scope: !984)
!1145 = !DILocation(line: 556, column: 39, scope: !1085)
!1146 = !DILocation(line: 0, scope: !1085)
!1147 = !DILocation(line: 557, column: 8, scope: !1148)
!1148 = distinct !DILexicalBlock(scope: !1085, file: !3, line: 557, column: 7)
!1149 = !DILocation(line: 557, column: 7, scope: !1085)
!1150 = !DILocation(line: 560, column: 10, scope: !1085)
!1151 = !DILocation(line: 560, column: 24, scope: !1085)
!1152 = !{!319, !256, i64 8}
!1153 = !DILocation(line: 562, column: 17, scope: !1085)
!1154 = !DILocation(line: 562, column: 3, scope: !1085)
!1155 = !DILocation(line: 566, column: 1, scope: !984)
!1156 = distinct !DISubprogram(name: "tc_memcached_tx_get_parse_main", scope: !3, file: !3, line: 569, type: !985, scopeLine: 570, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !1157)
!1157 = !{!1158, !1159, !1160, !1161, !1162, !1163, !1164, !1165, !1167, !1168, !1169, !1170, !1173, !1175, !1182, !1187, !1194, !1196, !1197, !1198, !1200, !1203, !1208}
!1158 = !DILocalVariable(name: "skb", arg: 1, scope: !1156, file: !3, line: 569, type: !987)
!1159 = !DILocalVariable(name: "data_end", scope: !1156, file: !3, line: 571, type: !6)
!1160 = !DILocalVariable(name: "data", scope: !1156, file: !3, line: 572, type: !6)
!1161 = !DILocalVariable(name: "payload", scope: !1156, file: !3, line: 573, type: !46)
!1162 = !DILocalVariable(name: "zero", scope: !1156, file: !3, line: 574, type: !31)
!1163 = !DILocalVariable(name: "hash", scope: !1156, file: !3, line: 576, type: !51)
!1164 = !DILocalVariable(name: "hash2", scope: !1156, file: !3, line: 577, type: !51)
!1165 = !DILocalVariable(name: "off", scope: !1166, file: !3, line: 580, type: !31)
!1166 = distinct !DILexicalBlock(scope: !1156, file: !3, line: 580, column: 2)
!1167 = !DILocalVariable(name: "cache_idx", scope: !1156, file: !3, line: 587, type: !51)
!1168 = !DILocalVariable(name: "entry", scope: !1156, file: !3, line: 588, type: !89)
!1169 = !DILocalVariable(name: "new_key_hotness", scope: !1156, file: !3, line: 593, type: !51)
!1170 = !DILocalVariable(name: "diff", scope: !1171, file: !3, line: 600, type: !50)
!1171 = distinct !DILexicalBlock(scope: !1172, file: !3, line: 599, column: 43)
!1172 = distinct !DILexicalBlock(scope: !1156, file: !3, line: 599, column: 6)
!1173 = !DILocalVariable(name: "off", scope: !1174, file: !3, line: 603, type: !31)
!1174 = distinct !DILexicalBlock(scope: !1171, file: !3, line: 603, column: 3)
!1175 = !DILocalVariable(name: "____fmt", scope: !1176, file: !3, line: 618, type: !1179)
!1176 = distinct !DILexicalBlock(scope: !1177, file: !3, line: 618, column: 3)
!1177 = distinct !DILexicalBlock(scope: !1178, file: !3, line: 615, column: 53)
!1178 = distinct !DILexicalBlock(scope: !1156, file: !3, line: 615, column: 5)
!1179 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, size: 560, elements: !1180)
!1180 = !{!1181}
!1181 = !DISubrange(count: 70)
!1182 = !DILocalVariable(name: "____fmt", scope: !1183, file: !3, line: 619, type: !1184)
!1183 = distinct !DILexicalBlock(scope: !1177, file: !3, line: 619, column: 3)
!1184 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, size: 472, elements: !1185)
!1185 = !{!1186}
!1186 = !DISubrange(count: 59)
!1187 = !DILocalVariable(name: "____fmt", scope: !1188, file: !3, line: 624, type: !1191)
!1188 = distinct !DILexicalBlock(scope: !1189, file: !3, line: 624, column: 3)
!1189 = distinct !DILexicalBlock(scope: !1190, file: !3, line: 622, column: 63)
!1190 = distinct !DILexicalBlock(scope: !1178, file: !3, line: 622, column: 11)
!1191 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, size: 504, elements: !1192)
!1192 = !{!1193}
!1193 = !DISubrange(count: 63)
!1194 = !DILocalVariable(name: "____fmt", scope: !1195, file: !3, line: 625, type: !1184)
!1195 = distinct !DILexicalBlock(scope: !1189, file: !3, line: 625, column: 3)
!1196 = !DILocalVariable(name: "old_key_hotness", scope: !1156, file: !3, line: 629, type: !51)
!1197 = !DILocalVariable(name: "count", scope: !1156, file: !3, line: 634, type: !31)
!1198 = !DILocalVariable(name: "j", scope: !1199, file: !3, line: 638, type: !31)
!1199 = distinct !DILexicalBlock(scope: !1156, file: !3, line: 638, column: 2)
!1200 = !DILocalVariable(name: "stats", scope: !1201, file: !3, line: 659, type: !228)
!1201 = distinct !DILexicalBlock(scope: !1202, file: !3, line: 651, column: 18)
!1202 = distinct !DILexicalBlock(scope: !1156, file: !3, line: 651, column: 6)
!1203 = !DILocalVariable(name: "____fmt", scope: !1204, file: !3, line: 679, type: !1205)
!1204 = distinct !DILexicalBlock(scope: !1156, file: !3, line: 679, column: 2)
!1205 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, size: 432, elements: !1206)
!1206 = !{!1207}
!1207 = !DISubrange(count: 54)
!1208 = !DILocalVariable(name: "____fmt", scope: !1209, file: !3, line: 680, type: !1184)
!1209 = distinct !DILexicalBlock(scope: !1156, file: !3, line: 680, column: 2)
!1210 = !DILocation(line: 0, scope: !1156)
!1211 = !DILocation(line: 571, column: 38, scope: !1156)
!1212 = !DILocation(line: 571, column: 27, scope: !1156)
!1213 = !DILocation(line: 571, column: 19, scope: !1156)
!1214 = !DILocation(line: 572, column: 34, scope: !1156)
!1215 = !DILocation(line: 572, column: 23, scope: !1156)
!1216 = !DILocation(line: 572, column: 15, scope: !1156)
!1217 = !DILocation(line: 573, column: 95, scope: !1156)
!1218 = !DILocation(line: 574, column: 2, scope: !1156)
!1219 = !DILocation(line: 574, column: 15, scope: !1156)
!1220 = !DILocation(line: 0, scope: !1166)
!1221 = !DILocation(line: 580, column: 52, scope: !1222)
!1222 = distinct !DILexicalBlock(scope: !1166, file: !3, line: 580, column: 2)
!1223 = !DILocation(line: 580, column: 62, scope: !1222)
!1224 = !DILocation(line: 580, column: 66, scope: !1222)
!1225 = !DILocation(line: 580, column: 69, scope: !1222)
!1226 = !DILocation(line: 580, column: 81, scope: !1222)
!1227 = !DILocation(line: 580, column: 84, scope: !1222)
!1228 = !DILocation(line: 580, column: 97, scope: !1222)
!1229 = !DILocation(line: 580, column: 2, scope: !1166)
!1230 = !DILocation(line: 587, column: 2, scope: !1156)
!1231 = !DILocation(line: 587, column: 23, scope: !1156)
!1232 = !DILocation(line: 587, column: 6, scope: !1156)
!1233 = !DILocation(line: 588, column: 40, scope: !1156)
!1234 = !DILocation(line: 589, column: 7, scope: !1235)
!1235 = distinct !DILexicalBlock(scope: !1156, file: !3, line: 589, column: 6)
!1236 = !DILocation(line: 589, column: 6, scope: !1156)
!1237 = !DILocation(line: 581, column: 8, scope: !1238)
!1238 = distinct !DILexicalBlock(scope: !1222, file: !3, line: 580, column: 112)
!1239 = !DILocation(line: 582, column: 8, scope: !1238)
!1240 = !DILocation(line: 583, column: 9, scope: !1238)
!1241 = !DILocation(line: 584, column: 9, scope: !1238)
!1242 = !DILocation(line: 580, column: 108, scope: !1222)
!1243 = !DILocation(line: 580, column: 35, scope: !1222)
!1244 = distinct !{!1244, !1229, !1245, !348}
!1245 = !DILocation(line: 585, column: 2, scope: !1166)
!1246 = !DILocation(line: 594, column: 32, scope: !1247)
!1247 = distinct !DILexicalBlock(scope: !1156, file: !3, line: 594, column: 6)
!1248 = !DILocation(line: 594, column: 50, scope: !1247)
!1249 = !DILocation(line: 594, column: 6, scope: !1156)
!1250 = !DILocation(line: 594, column: 13, scope: !1247)
!1251 = !DILocation(line: 595, column: 27, scope: !1252)
!1252 = distinct !DILexicalBlock(scope: !1247, file: !3, line: 594, column: 63)
!1253 = !DILocation(line: 595, column: 22, scope: !1252)
!1254 = !DILocation(line: 595, column: 55, scope: !1252)
!1255 = !DILocation(line: 595, column: 70, scope: !1252)
!1256 = !DILocation(line: 595, column: 65, scope: !1252)
!1257 = !DILocation(line: 595, column: 100, scope: !1252)
!1258 = !DILocation(line: 595, column: 62, scope: !1252)
!1259 = !DILocation(line: 595, column: 115, scope: !1252)
!1260 = !DILocation(line: 595, column: 110, scope: !1252)
!1261 = !DILocation(line: 595, column: 145, scope: !1252)
!1262 = !DILocation(line: 595, column: 107, scope: !1252)
!1263 = !DILocation(line: 595, column: 159, scope: !1252)
!1264 = !DILocation(line: 595, column: 154, scope: !1252)
!1265 = !DILocation(line: 595, column: 151, scope: !1252)
!1266 = !DILocation(line: 596, column: 2, scope: !1252)
!1267 = !DILocation(line: 598, column: 24, scope: !1156)
!1268 = !DILocation(line: 598, column: 2, scope: !1156)
!1269 = !DILocation(line: 599, column: 13, scope: !1172)
!1270 = !DILocation(line: 599, column: 6, scope: !1172)
!1271 = !DILocation(line: 599, column: 19, scope: !1172)
!1272 = !DILocation(line: 599, column: 29, scope: !1172)
!1273 = !DILocation(line: 599, column: 34, scope: !1172)
!1274 = !DILocation(line: 599, column: 6, scope: !1156)
!1275 = !DILocation(line: 0, scope: !1174)
!1276 = !DILocation(line: 0, scope: !1277)
!1277 = distinct !DILexicalBlock(scope: !1174, file: !3, line: 603, column: 3)
!1278 = !DILocation(line: 603, column: 53, scope: !1277)
!1279 = !DILocation(line: 603, column: 158, scope: !1277)
!1280 = !DILocation(line: 603, column: 36, scope: !1277)
!1281 = distinct !{!1281, !1282, !1283, !348}
!1282 = !DILocation(line: 603, column: 3, scope: !1174)
!1283 = !DILocation(line: 608, column: 3, scope: !1174)
!1284 = !DILocation(line: 603, column: 63, scope: !1277)
!1285 = !DILocation(line: 603, column: 67, scope: !1277)
!1286 = !DILocation(line: 603, column: 70, scope: !1277)
!1287 = !DILocation(line: 603, column: 82, scope: !1277)
!1288 = !DILocation(line: 603, column: 98, scope: !1277)
!1289 = !DILocation(line: 603, column: 89, scope: !1277)
!1290 = !DILocation(line: 603, column: 102, scope: !1277)
!1291 = !DILocation(line: 603, column: 106, scope: !1277)
!1292 = !DILocation(line: 603, column: 119, scope: !1277)
!1293 = !DILocation(line: 603, column: 146, scope: !1277)
!1294 = !DILocation(line: 603, column: 126, scope: !1277)
!1295 = !DILocation(line: 604, column: 25, scope: !1296)
!1296 = distinct !DILexicalBlock(scope: !1297, file: !3, line: 604, column: 8)
!1297 = distinct !DILexicalBlock(scope: !1277, file: !3, line: 603, column: 162)
!1298 = !DILocation(line: 604, column: 8, scope: !1297)
!1299 = !DILocation(line: 610, column: 4, scope: !1300)
!1300 = distinct !DILexicalBlock(scope: !1301, file: !3, line: 609, column: 18)
!1301 = distinct !DILexicalBlock(scope: !1171, file: !3, line: 609, column: 7)
!1302 = !DILocation(line: 615, column: 18, scope: !1178)
!1303 = !DILocation(line: 615, column: 22, scope: !1178)
!1304 = !DILocation(line: 615, column: 32, scope: !1178)
!1305 = !DILocation(line: 615, column: 43, scope: !1178)
!1306 = !DILocation(line: 615, column: 5, scope: !1156)
!1307 = !DILocation(line: 616, column: 21, scope: !1177)
!1308 = !DILocation(line: 617, column: 3, scope: !1177)
!1309 = !DILocation(line: 618, column: 3, scope: !1176)
!1310 = !DILocation(line: 618, column: 3, scope: !1177)
!1311 = !DILocation(line: 619, column: 3, scope: !1183)
!1312 = !DILocation(line: 619, column: 3, scope: !1177)
!1313 = !DILocation(line: 620, column: 3, scope: !1177)
!1314 = !DILocation(line: 622, column: 18, scope: !1190)
!1315 = !DILocation(line: 622, column: 29, scope: !1190)
!1316 = !DILocation(line: 622, column: 38, scope: !1190)
!1317 = !DILocation(line: 622, column: 42, scope: !1190)
!1318 = !DILocation(line: 622, column: 58, scope: !1190)
!1319 = !DILocation(line: 622, column: 11, scope: !1178)
!1320 = !DILocation(line: 623, column: 3, scope: !1189)
!1321 = !DILocation(line: 624, column: 3, scope: !1188)
!1322 = !DILocation(line: 624, column: 3, scope: !1189)
!1323 = !DILocation(line: 625, column: 3, scope: !1195)
!1324 = !DILocation(line: 625, column: 3, scope: !1189)
!1325 = !DILocation(line: 626, column: 3, scope: !1189)
!1326 = !DILocation(line: 630, column: 13, scope: !1327)
!1327 = distinct !DILexicalBlock(scope: !1156, file: !3, line: 630, column: 6)
!1328 = !DILocation(line: 630, column: 19, scope: !1327)
!1329 = !DILocation(line: 630, column: 6, scope: !1156)
!1330 = !DILocation(line: 631, column: 27, scope: !1331)
!1331 = distinct !DILexicalBlock(scope: !1327, file: !3, line: 630, column: 85)
!1332 = !DILocation(line: 631, column: 22, scope: !1331)
!1333 = !DILocation(line: 631, column: 59, scope: !1331)
!1334 = !DILocation(line: 631, column: 74, scope: !1331)
!1335 = !DILocation(line: 631, column: 69, scope: !1331)
!1336 = !DILocation(line: 631, column: 108, scope: !1331)
!1337 = !DILocation(line: 631, column: 66, scope: !1331)
!1338 = !DILocation(line: 631, column: 123, scope: !1331)
!1339 = !DILocation(line: 631, column: 118, scope: !1331)
!1340 = !DILocation(line: 631, column: 157, scope: !1331)
!1341 = !DILocation(line: 631, column: 115, scope: !1331)
!1342 = !DILocation(line: 631, column: 171, scope: !1331)
!1343 = !DILocation(line: 631, column: 166, scope: !1331)
!1344 = !DILocation(line: 631, column: 163, scope: !1331)
!1345 = !DILocation(line: 632, column: 2, scope: !1331)
!1346 = !DILocation(line: 635, column: 9, scope: !1156)
!1347 = !DILocation(line: 635, column: 13, scope: !1156)
!1348 = !DILocation(line: 0, scope: !1199)
!1349 = !DILocation(line: 0, scope: !1350)
!1350 = distinct !DILexicalBlock(scope: !1351, file: !3, line: 638, column: 97)
!1351 = distinct !DILexicalBlock(scope: !1199, file: !3, line: 638, column: 2)
!1352 = !DILocation(line: 638, column: 51, scope: !1351)
!1353 = !DILocation(line: 638, column: 61, scope: !1351)
!1354 = !DILocation(line: 638, column: 63, scope: !1351)
!1355 = !DILocation(line: 638, column: 66, scope: !1351)
!1356 = !DILocation(line: 638, column: 87, scope: !1351)
!1357 = !DILocation(line: 638, column: 78, scope: !1351)
!1358 = !DILocation(line: 651, column: 12, scope: !1202)
!1359 = !DILocation(line: 651, column: 6, scope: !1156)
!1360 = !DILocation(line: 639, column: 20, scope: !1350)
!1361 = !DILocation(line: 639, column: 3, scope: !1350)
!1362 = !DILocation(line: 639, column: 18, scope: !1350)
!1363 = !DILocation(line: 640, column: 13, scope: !1350)
!1364 = !DILocation(line: 641, column: 7, scope: !1365)
!1365 = distinct !DILexicalBlock(scope: !1350, file: !3, line: 641, column: 7)
!1366 = !DILocation(line: 641, column: 18, scope: !1365)
!1367 = !DILocation(line: 641, column: 7, scope: !1350)
!1368 = !DILocation(line: 638, column: 93, scope: !1351)
!1369 = !DILocation(line: 638, column: 29, scope: !1351)
!1370 = distinct !{!1370, !1371, !1372, !348}
!1371 = !DILocation(line: 638, column: 2, scope: !1199)
!1372 = !DILocation(line: 643, column: 2, scope: !1199)
!1373 = !DILocation(line: 655, column: 16, scope: !1201)
!1374 = !DILocation(line: 656, column: 10, scope: !1201)
!1375 = !DILocation(line: 656, column: 16, scope: !1201)
!1376 = !DILocation(line: 657, column: 21, scope: !1201)
!1377 = !DILocation(line: 658, column: 3, scope: !1201)
!1378 = !DILocation(line: 659, column: 39, scope: !1201)
!1379 = !DILocation(line: 0, scope: !1201)
!1380 = !DILocation(line: 660, column: 8, scope: !1381)
!1381 = distinct !DILexicalBlock(scope: !1201, file: !3, line: 660, column: 7)
!1382 = !DILocation(line: 660, column: 7, scope: !1201)
!1383 = !DILocation(line: 663, column: 10, scope: !1201)
!1384 = !DILocation(line: 663, column: 22, scope: !1201)
!1385 = !{!319, !256, i64 24}
!1386 = !DILocation(line: 665, column: 23, scope: !1387)
!1387 = distinct !DILexicalBlock(scope: !1201, file: !3, line: 665, column: 7)
!1388 = !DILocation(line: 665, column: 59, scope: !1387)
!1389 = !DILocation(line: 665, column: 40, scope: !1387)
!1390 = !DILocation(line: 666, column: 11, scope: !1391)
!1391 = distinct !DILexicalBlock(scope: !1387, file: !3, line: 665, column: 77)
!1392 = !DILocation(line: 666, column: 26, scope: !1391)
!1393 = !{!319, !256, i64 32}
!1394 = !DILocation(line: 667, column: 3, scope: !1391)
!1395 = !DILocation(line: 667, column: 30, scope: !1396)
!1396 = distinct !DILexicalBlock(scope: !1387, file: !3, line: 667, column: 14)
!1397 = !DILocation(line: 667, column: 67, scope: !1396)
!1398 = !DILocation(line: 667, column: 48, scope: !1396)
!1399 = !DILocation(line: 668, column: 11, scope: !1400)
!1400 = distinct !DILexicalBlock(scope: !1396, file: !3, line: 667, column: 86)
!1401 = !DILocation(line: 668, column: 28, scope: !1400)
!1402 = !{!319, !256, i64 36}
!1403 = !DILocation(line: 669, column: 3, scope: !1400)
!1404 = !DILocation(line: 669, column: 48, scope: !1405)
!1405 = distinct !DILexicalBlock(scope: !1396, file: !3, line: 669, column: 14)
!1406 = !DILocation(line: 670, column: 11, scope: !1407)
!1407 = distinct !DILexicalBlock(scope: !1405, file: !3, line: 669, column: 85)
!1408 = !DILocation(line: 670, column: 27, scope: !1407)
!1409 = !{!319, !256, i64 40}
!1410 = !DILocation(line: 671, column: 3, scope: !1407)
!1411 = !DILocation(line: 671, column: 47, scope: !1412)
!1412 = distinct !DILexicalBlock(scope: !1405, file: !3, line: 671, column: 14)
!1413 = !DILocation(line: 672, column: 11, scope: !1414)
!1414 = distinct !DILexicalBlock(scope: !1412, file: !3, line: 671, column: 85)
!1415 = !DILocation(line: 672, column: 27, scope: !1414)
!1416 = !{!319, !256, i64 44}
!1417 = !DILocation(line: 673, column: 3, scope: !1414)
!1418 = !DILocation(line: 676, column: 3, scope: !1419)
!1419 = distinct !DILexicalBlock(scope: !1202, file: !3, line: 675, column: 9)
!1420 = !DILocation(line: 679, column: 2, scope: !1204)
!1421 = !DILocation(line: 679, column: 2, scope: !1156)
!1422 = !DILocation(line: 680, column: 2, scope: !1209)
!1423 = !DILocation(line: 680, column: 2, scope: !1156)
!1424 = !DILocation(line: 685, column: 2, scope: !1156)
!1425 = !DILocation(line: 686, column: 1, scope: !1156)
