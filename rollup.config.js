import commonjs from "@rollup/plugin-commonjs";
import typescript from "rollup-plugin-typescript2";
import copy from "rollup-plugin-copy";

export default {
  input: "src/index.ts",
  output: {
    dir: "dist",
    format: "cjs",
  },
  preserveModules: true,
  plugins: [
    commonjs(),
    typescript(),
    copy({
      targets: [
        { src: "package.json", dest: "dist" },
        { src: "README.md", dest: "dist" },
      ],
    }),
  ],
};
