'use strict'

const chai = require('chai')
const expect = chai.expect


const app = require('../index');

describe('Test Hello world', function () {
  it('should to be a string', function () {
      expect('Hello world').to.be.a('string')
  })

  it('app should to be an object', function () {
      expect(app).to.be.a('function')
  })
})
