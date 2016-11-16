/*!
 * Copyright (C) by Nils Sommer, 2016
 */

module.exports = function (grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    clean: {
      js: 'dist/'
    },

    coffee: {
      compile: {
        options: {
          sourceMap: true
        },
        files: {
          'dist/datepicker.js': 'coffee/**/*.coffee'
        }
      }
    },

    uglify: {
      options: {
        sourceMap: true
      },
      bundle: {
        files: {
          'dist/datepicker.min.js': 'dist/datepicker.js'
        }
      }
    },

    watch: {
      coffee: {
        files: ['coffee/**/*.coffee'],
        tasks: ['build-js']
      }
    },

    connect: {
      server: {
        options: {
          port: 8000,
          base: '.',
          keepalive: true
        }
      }
    }
  })

  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-connect');

  grunt.registerTask('build-js', ['clean:js', 'coffee', 'uglify']);
  grunt.registerTask('build', ['build-js']);
}