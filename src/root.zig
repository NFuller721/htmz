const std = @import("std");

pub const Template = struct {
    const Self = @This();

    const Error = std.Io.Dir.ReadFileError || error{TemplatesDirNotFound};

    pub fn init(io: std.Io, file_path: []const u8) Error!Self {
        const templates = try findTemplatesDirectory(io);

        var buffer: [4096]u8 = undefined;
        const bytes = try templates.readFile(io, file_path, &buffer);

        std.debug.print("{s}\n", .{bytes});

        return .{};
    }

    fn findTemplatesDirectory(io: std.Io) Error!std.Io.Dir {
        return std.Io.Dir.cwd().openDir(io, "templates", .{}) catch
            return Error.TemplatesDirNotFound;
    }

    pub fn render(_: *Self) Error![]const u8 {
        unreachable;
    }
};

pub const TokenTag = enum {
    text,
};

pub const Token = struct {
    tag: TokenTag,
    slice: []const u8,
};

pub const Scanner = struct {
    input: []const u8,
    index: u64,

    const Self = @This();

    fn peek(self: Self) ?u8 {
        if (self.index >= self.input.len) return null;
        return self.input[self.index];
    }

    fn advance(self: *Self) ?u8 {
        if (self.index >= self.input.len) return null;
        const char = self.input[self.index];
        self.index += 1;
        return char;
    }

    pub fn next(self: *Self) ?Token {
        const start = self.index;
        while (self.peek()) |char| {
            switch (char) {
                '{' => {},
                else => {},
            }
        }
    }
};

test {
    const io = std.testing.io;

    _ = try Template.init(io, "example.html");
}
