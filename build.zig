const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Create the library
    const lib = b.addStaticLibrary(.{
        .name = "ozz_animation",
        .target = target,
        .optimize = optimize,
    });

    // Link C++ standard library
    lib.linkLibCpp();

    // Add include directories
    lib.addIncludePath(b.path("include"));
    lib.addIncludePath(b.path("include/ozz"));

    // Add source files with proper path format
    const source_files = &[_][]const u8{
        "animation/offline/additive_animation_builder.cc",
        "animation/offline/animation_builder.cc",
        "animation/offline/animation_optimizer.cc",
        "animation/offline/motion_extractor.cc",
        "animation/offline/raw_animation_archive.cc",
        "animation/offline/raw_animation_utils.cc",
        "animation/offline/raw_animation.cc",
        "animation/offline/raw_skeleton_archive.cc",
        "animation/offline/raw_skeleton.cc",
        "animation/offline/raw_track_utils.cc",
        "animation/offline/raw_track.cc",
        "animation/offline/skeleton_builder.cc",
        "animation/offline/track_builder.cc",
        "animation/offline/track_optimizer.cc",
        "animation/offline/fbx/fbx_animation.cc",
        "animation/offline/fbx/fbx_skeleton.cc",
        "animation/offline/fbx/fbx.cc",
        "animation/offline/fbx/fbx2ozz_anim.cc",
        "animation/offline/fbx/fbx2ozz_skel.cc",
        "animation/offline/fbx/fbx2ozz.cc",
        "animation/offline/gltf/gltf2ozz.cc",
        "animation/offline/tools/dump2ozz.cc",
        "animation/offline/tools/import2ozz_anim.cc",
        "animation/offline/tools/import2ozz_config.cc",
        "animation/offline/tools/import2ozz_skel.cc",
        "animation/offline/tools/import2ozz_track.cc",
        "animation/offline/tools/import2ozz.cc",
        "animation/runtime/animation_utils.cc",
        "animation/runtime/animation.cc",
        "animation/runtime/blending_job.cc",
        "animation/runtime/ik_aim_job.cc",
        "animation/runtime/ik_two_bone_job.cc",
        "animation/runtime/local_to_model_job.cc",
        "animation/runtime/motion_blending_job.cc",
        "animation/runtime/sampling_job.cc",
        "animation/runtime/skeleton_utils.cc",
        "animation/runtime/skeleton.cc",
        "animation/runtime/track_sampling_job.cc",
        "animation/runtime/track_triggering_job.cc",
        "animation/runtime/track.cc",
        "base/log.cc",
        "base/platform.cc",
        "base/containers/string_archive.cc",
        "base/encode/group_varint.cc",
        "base/io/archive.cc",
        "base/io/stream.cc",
        "base/maths/box.cc",
        "base/maths/math_archive.cc",
        "base/maths/simd_math_archive.cc",
        "base/maths/simd_math.cc",
        "base/maths/soa_math_archive.cc",
        "base/memory/allocator.cc",
        "geometry/runtime/skinning_job.cc",
        "options/options.cc",
    };

    // Add source files
    lib.addCSourceFiles(.{
        .files = source_files,
        .root = .{ .src_path = .{ .owner = b, .sub_path = "src" } },
        .language = .cpp,
    });

    // Install the library
    b.installArtifact(lib);

    // Install header files
    const headers_install = b.addInstallDirectory(.{
        .source_dir = b.path("include"),
        .install_dir = .header,
        .install_subdir = "ozz",
    });
    b.getInstallStep().dependOn(&headers_install.step);
}
