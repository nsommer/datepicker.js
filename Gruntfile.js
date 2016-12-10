/*!
 * Copyright (C) by Nils Sommer, 2016
 */

module.exports = function (grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    clean: {
      js:  [
        'dist/*.js',
        'dist/*.js.map',
        'dist/*.coffee'
      ],
      css: [
        'dist/*.css',
        'dist/*.css.map'
      ]
    },

    coffee: {
      compile: {
        options: {
          sourceMap: true
        },
        files: {
          'dist/datepicker.js': [
            'coffee/views/*.coffee',
            'coffee/datepicker.coffee'
          ]
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
    
    sass: {
      bundle: {
        options: {
          style: 'expanded'
        },
        files: {
          'dist/datepicker.css': 'scss/datepicker.scss'
        }
      }
    },
    
    cssmin: {
      options: {
        sourceMap: true
      },
      bundle: {
        files: [{
          expand: true,
          cwd: 'dist',
          src: ['*.css', '!*.min.css'],
          dest: 'dist',
          ext: '.min.css'
        }]
      }
    },

    watch: {
      coffee: {
        files: ['coffee/**/*.coffee'],
        tasks: ['build:js']
      },
      scss: {
        files: ['scss/**/*.scss'],
        tasks: ['build:css']
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
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-connect');

  grunt.registerTask('build:css', ['clean:css', 'sass', 'cssmin']);
  grunt.registerTask('build:js', ['clean:js', 'coffee', 'uglify']);
  grunt.registerTask('build', ['build:css', 'build:js']);
}