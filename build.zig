const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib_mod = b.createModule(.{
        .root_source_file = b.addWriteFiles().add("empty.cc", ""),
        .target = target,
        .optimize = optimize,
    });

    const lib = b.addStaticLibrary(.{
        .name = "ozz_animation",
        .root_module = lib_mod,
    });

    lib.linkLibCpp();
    lib.addIncludePath(b.path("include"));
    lib.addIncludePath(b.path("include/ozz"));

    lib.addCSourceFiles(.{ .files = &.{ "animation\\offline\\additive_animation_builder.cc", "animation\\offline\\animation_builder.cc", "animation\\offline\\animation_optimizer.cc", "animation\\offline\\motion_extractor.cc", "animation\\offline\\raw_animation_archive.cc", "animation\\offline\\raw_animation_utils.cc", "animation\\offline\\raw_animation.cc", "animation\\offline\\raw_skeleton_archive.cc", "animation\\offline\\raw_skeleton.cc", "animation\\offline\\raw_track_utils.cc", "animation\\offline\\raw_track.cc", "animation\\offline\\skeleton_builder.cc", "animation\\offline\\track_builder.cc", "animation\\offline\\track_optimizer.cc", "animation\\offline\\fbx\\fbx_animation.cc", "animation\\offline\\fbx\\fbx_skeleton.cc", "animation\\offline\\fbx\\fbx.cc", "animation\\offline\\fbx\\fbx2ozz_anim.cc", "animation\\offline\\fbx\\fbx2ozz_skel.cc", "animation\\offline\\fbx\\fbx2ozz.cc", "animation\\offline\\gltf\\gltf2ozz.cc", "animation\\offline\\tools\\dump2ozz.cc", "animation\\offline\\tools\\import2ozz_anim.cc", "animation\\offline\\tools\\import2ozz_config.cc", "animation\\offline\\tools\\import2ozz_skel.cc", "animation\\offline\\tools\\import2ozz_track.cc", "animation\\offline\\tools\\import2ozz.cc", "animation\\runtime\\animation_utils.cc", "animation\\runtime\\animation.cc", "animation\\runtime\\blending_job.cc", "animation\\runtime\\ik_aim_job.cc", "animation\\runtime\\ik_two_bone_job.cc", "animation\\runtime\\local_to_model_job.cc", "animation\\runtime\\motion_blending_job.cc", "animation\\runtime\\sampling_job.cc", "animation\\runtime\\skeleton_utils.cc", "animation\\runtime\\skeleton.cc", "animation\\runtime\\track_sampling_job.cc", "animation\\runtime\\track_triggering_job.cc", "animation\\runtime\\track.cc", "base\\log.cc", "base\\platform.cc", "base\\containers\\string_archive.cc", "base\\encode\\group_varint.cc", "base\\io\\archive.cc", "base\\io\\stream.cc", "base\\maths\\box.cc", "base\\maths\\math_archive.cc", "base\\maths\\simd_math_archive.cc", "base\\maths\\simd_math.cc", "base\\maths\\soa_math_archive.cc", "base\\memory\\allocator.cc", "geometry\\runtime\\skinning_job.cc", "options\\options.cc" }, .root = .{ .src_path = .{ .owner = b, .sub_path = "src" } }, .language = .cpp });

    b.installArtifact(lib);
}
